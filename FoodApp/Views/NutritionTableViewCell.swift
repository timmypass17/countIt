//
//  NutritionTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/4/24.
//

import UIKit

class NutritionTableViewCell: UITableViewCell {
    static let reuseIdentifier = "NutritionCell"
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
//        label.backgroundColor = .red
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
//    var descriptionLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .secondaryLabel
//        label.numberOfLines = 1
//        label.lineBreakMode = .byTruncatingTail
//        label.font = UIFont.preferredFont(forTextStyle: .caption1)
//        return label
//    }()
    
    var amountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .secondaryLabel
//        label.textColor = .systemBlue
//        label.backgroundColor = .blue
        return label
    }()
    
    var percentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .secondaryLabel
//        label.backgroundColor = .green
//        label.textColor = .systemBlue
        return label
    }()
    
//    var goalLabel: UILabel = {
//        let label = UILabel()
//        label.numberOfLines = 1
//        label.lineBreakMode = .byTruncatingTail
//        label.textColor = .secondaryLabel
//        label.font = UIFont.preferredFont(forTextStyle: .caption1)
//        return label
//    }()
    
    var progressView: UIProgressView = {
        let progressView = UIProgressView()
        return progressView
    }()
    
    var nameStackView: UIStackView = {
        let vstack = UIStackView()
        vstack.axis = .horizontal
        vstack.spacing = 8
        return vstack
    }()
    
    var valuesStackView: UIStackView = {
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.alignment = .trailing
        vstack.spacing = 4
        return vstack
    }()
    
    var hstack: UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .horizontal
        return hstack
    }()
        
    var container: UIStackView = {
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.spacing = 8
        vstack.translatesAutoresizingMaskIntoConstraints = false
        return vstack
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        nameStackView.addArrangedSubview(nameLabel)
        nameStackView.addArrangedSubview(amountLabel)
        nameStackView.addArrangedSubview(percentLabel)
                
        container.addArrangedSubview(nameStackView)
        container.addArrangedSubview(progressView)
        
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
        
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with foodNutrient: FoodNutrient, foodPortion: FoodPortion, quantity: Int) {
        nameLabel.text = foodNutrient.description
//        descriptionLabel.text = "Essential for building and repairing tissues in the body."
        let nutrientAmount = (calculateNutrientPerServing(nutrientPer100g: foodNutrient.amount ?? 0, servingSizeGramWeight: foodPortion.gramWeight) * Float(quantity))
        if let nutrientID = foodNutrient.nutrient?.id,
           let nutrientGoal = Settings.shared.userDailyValues[nutrientID] {
            let progress = nutrientAmount / nutrientGoal
            if nutrientAmount < 1 {
                amountLabel.text = "\(nutrientAmount.formattedString(decimalPlaces: 1)) \(foodNutrient.nutrient?.unitName ?? "Unspecified")"
            } else {
                amountLabel.text = "\(Int(nutrientAmount)) \(foodNutrient.nutrient?.unitName ?? "Unspecified")"
            }
            percentLabel.text = "\(Int((progress * 100).rounded()))%"
            progressView.progress = progress
        } else {
            amountLabel.text = "Missing nutrient goal"
        }
    }
}
