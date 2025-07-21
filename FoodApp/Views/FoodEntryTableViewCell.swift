//
//  FoodEntryTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//

import UIKit

class FoodEntryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "FoodEntryCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.textColor = Settings.shared.currentTheme.label.uiColor
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = Settings.shared.currentTheme.secondary.uiColor
        return label
    }()
    
    let caloriesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.textColor = Settings.shared.currentTheme.label.uiColor
        return label
    }()
    
    let labelContainer: UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .vertical
        return hstack
    }()
    
    let container: UIStackView = {
        let hstack = UIStackView()
        hstack.spacing = 8
        hstack.axis = .horizontal
        hstack.translatesAutoresizingMaskIntoConstraints = false
        return hstack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor
        
        labelContainer.addArrangedSubview(titleLabel)
        labelContainer.addArrangedSubview(descriptionLabel)
        
        container.addArrangedSubview(labelContainer)
        container.addArrangedSubview(caloriesLabel)
        
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func  update(_ foodEntry: FoodEntry) {
        titleLabel.text = foodEntry.foodInfo?.name
        descriptionLabel.text = foodEntry.description()
        caloriesLabel.text = "\(Int(foodEntry.getNutrientAmount(.calories, quantity: Int(foodEntry.quantity))))"
        
        titleLabel.textColor = Settings.shared.currentTheme.label.uiColor
        descriptionLabel.textColor = Settings.shared.currentTheme.secondary.uiColor
        caloriesLabel.textColor = Settings.shared.currentTheme.label.uiColor
        backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor
    }
}
