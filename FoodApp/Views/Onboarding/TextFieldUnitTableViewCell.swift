
//
//  WeightInputTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/7/25.
//

import UIKit

class TextFieldUnitTableViewCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        textField.addAction(textFieldDidChange(), for: .editingChanged)
        return textField
    }()

    let unitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "lb"
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var editingChangedAction: ((String?) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(hex: "#252525")

        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(textField)
        container.addArrangedSubview(unitLabel)
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

    func textFieldDidChange() -> UIAction {
        return UIAction { _ in
            self.editingChangedAction?(self.textField.text)
        }
    }
}

class WeightTextFieldTableViewCell: TextFieldUnitTableViewCell {
    
    static let reuseIdentifier = "WeightTextFieldTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textField.placeholder = "Required"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(title: String, unit: WeightUnit, weightKg: Double?, editingChangedAction: @escaping (String?) -> Void) {
        titleLabel.text = title
        unitLabel.text = unit.singularSymbol
        if let weightKg {
            switch unit {
            case .pounds:
                textField.text = convertKilogramsToPounds(weightKg).trimmed
            case .kilograms:
                textField.text = weightKg.trimmed
            }
        } else {
            textField.text = nil
        }
        
        self.editingChangedAction = editingChangedAction
    }
}

class NutritionTextFieldTableViewCell: TextFieldUnitTableViewCell {
    
    static let reuseIdentifier = "NutritionTextFieldTableViewCell"
    
    func update(title: String, unit: String, value: Double?, placeholder: String, editingChangedAction: @escaping (String?) -> Void) {
        titleLabel.text = title
        unitLabel.text = unit
        if let value {
            textField.text = value.trimmed
        } else {
            textField.text = nil
        }
        textField.placeholder = placeholder
        self.editingChangedAction = editingChangedAction
    }
    
//    func update(_ nutrientId: NutrientId, value: Double?, editingChangedAction: @escaping (String?) -> Void) {
//        titleLabel.text = nutrientId.description
//        unitLabel.text = nutrientId.unitName
//        // set text field
//        if let value {
//            textField.text = value.trimmed
//        } else {
//            textField.text = nil
//        }
//        textField.placeholder = nutrientId.isRequired ? "Required" : "Optional"
//        self.editingChangedAction = editingChangedAction
//    }
//    
//    func update(title: String, description: String, value: Double?, placeholderText: String, editingChangedAction: @escaping (String?) -> Void) {
//        titleLabel.text = title
//        unitLabel.text = "g"
//        // set text field
//        if let value {
//            textField.text = value.trimmed
//        } else {
//            textField.text = nil
//        }
//        textField.placeholder = placeholderText
//        self.editingChangedAction = editingChangedAction
//    }
}
