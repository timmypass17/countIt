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
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()

    var amountLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .secondaryLabel
        return label
    }()
    
    var percentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
//        label.textColor = .secondaryLabel
        return label
    }()

    var progressView: UIProgressView = {
        let progressView = UIProgressView()
        return progressView
    }()
    
    var hstack: UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.spacing = 8
        return hstack
    }()
        
    var vstack: UIStackView = {
        let vstack = UIStackView()
        vstack.axis = .vertical
        vstack.spacing = 8
        vstack.translatesAutoresizingMaskIntoConstraints = false
        return vstack
    }()
    
    var leadingConstraint: NSLayoutConstraint!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        hstack.addArrangedSubview(nameLabel)
        hstack.addArrangedSubview(amountLabel)
        hstack.addArrangedSubview(percentLabel)
                
        vstack.addArrangedSubview(hstack)
        vstack.addArrangedSubview(progressView)
        
        contentView.addSubview(vstack)
        
        leadingConstraint = vstack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor)
        
        NSLayoutConstraint.activate([
            vstack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            vstack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            leadingConstraint,
            vstack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with foodNutrient: FoodNutrient, foodPortion: FoodPortion, quantity: Int, goal: Double) {
        nameLabel.text = foodNutrient.nutrient?.id.description
        let amount = Int(scaledNutrientAmount(amountPer100g: foodNutrient.amount ?? 0, actualServingSize: Double(foodPortion.gramWeight))) * quantity
        amountLabel.text = "\(amount) \(foodNutrient.nutrient?.unitName ?? "")"
        let value = foodNutrient.amount ?? 0
        var progress = 0.0
        if goal > 0 {
            progress = value / goal
        }
        let percentage = Int(((progress) * 100).rounded())
        if percentage < 1 {
            percentLabel.text = "-"
        } else {
            percentLabel.text = "\(percentage)%"
        }
        
        if let isSecondary = foodNutrient.nutrient?.id.isSecondary, isSecondary == true {
            nameLabel.textColor = .secondaryLabel
            leadingConstraint.constant = 25
        }  else if let isTertiary = foodNutrient.nutrient?.id.isTertiary, isTertiary == true {
            nameLabel.textColor = .secondaryLabel
            leadingConstraint.constant = 50
        } else {
            nameLabel.textColor = .label
            leadingConstraint.constant = 0
        }
        
        
//        let nutrientAmount = (calculateNutrientPerServing(nutrientPer100g: foodNutrient.amount ?? 0, servingSizeGramWeight: foodPortion.gramWeight) * Float(quantity))
//        if let nutrientID = foodNutrient.nutrient?.id,
//           let nutrientGoal = Settings.shared.userDailyValues[nutrientID] {
//            let progress = nutrientAmount / nutrientGoal
//            if nutrientAmount < 1 {
//                amountLabel.text = "\(nutrientAmount.formattedString(decimalPlaces: 1)) \(foodNutrient.nutrient?.unitName ?? "Unspecified")"
//            } else {
//                amountLabel.text = "\(Int(nutrientAmount)) \(foodNutrient.nutrient?.unitName ?? "Unspecified")"
//            }
//            let dailyValuePercent = Int((progress * 100).rounded())
//            percentLabel.text = dailyValuePercent > 0 ? "\(Int((progress * 100).rounded()))%" : "-"
//            progressView.progress = progress
//        } else {
//            amountLabel.text = "Missing nutrient goal"
//        }
        
//        if let isSecondary = foodNutrient.nutrient?.id.isSecondary, isSecondary == true {
//            nameLabel.textColor = .secondaryLabel
//            leadingConstraint.constant = 25
//        }  else if let isTertiary = foodNutrient.nutrient?.id.isTertiary, isTertiary == true {
//            nameLabel.textColor = .secondaryLabel
//            leadingConstraint.constant = 50
//        } else {
//            nameLabel.textColor = .label
//            leadingConstraint.constant = 0
//        }
        
        progressView.isHidden = true
    }
    
    func update(nutrientID: NutrientId, nutrientAmount: Float, nutrientGoal: Float) {
        nameLabel.text = nutrientID.description
        var progress: Float = 0
        if nutrientGoal > 0 {
            progress = nutrientAmount / nutrientGoal
        }
//        if nutrientAmount < 1 {
//            amountLabel.text = "\(nutrientAmount.formattedString(decimalPlaces: 1)) \(nutrientID.unit)"
//        } else {
//            amountLabel.text = "\(Int(nutrientAmount)) \(nutrientID.unit)"
//        }
        percentLabel.text = "\(Int((progress * 100).rounded()))%"
        progressView.progress = progress
    }
}
