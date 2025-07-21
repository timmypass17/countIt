//
//  CurrentWeightEditTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/12/25.
//

import UIKit

class CurrentWeightEditTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CurrentWeightEditTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.textAlignment = .right
        return textField
    }()
    
    let weightUnitLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(weightTextField)
        container.addArrangedSubview(weightUnitLabel)
                
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(weightPlaceholderText: String, weightUnit: WeightUnit) {
        weightTextField.placeholder = weightPlaceholderText
        weightUnitLabel.text = weightUnit.pluralSymbol
    }
}
