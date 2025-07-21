//
//  UpdateNutrientTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/1/25.
//

import UIKit

protocol TextFieldInputTableViewCellDelegate: AnyObject {
    func textFieldInputTableViewCell(_ sender: TextFieldInputTableViewCell, textDidChange text: String?)
}

class TextFieldInputTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "TextFieldInputTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.textAlignment = .right
        textField.addAction(amountTextValueChanged(), for: .editingChanged)
        return textField
    }()
    
    let unitLabel: UILabel = {
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

    weak var delegate: TextFieldInputTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor
        
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(amountTextField)
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
    
    func update(title: String, valueText: String?, placeholderText: String, unit: String?) {
        titleLabel.text = title
        amountTextField.text = valueText
        amountTextField.placeholder = placeholderText
        unitLabel.text = unit
        
        if let unit = unit, !unit.isEmpty {
            unitLabel.text = unit
            if !container.arrangedSubviews.contains(unitLabel) {
                container.addArrangedSubview(unitLabel)
            }
        } else {
            unitLabel.text = nil
            container.removeArrangedSubview(unitLabel)  // tells the stack view to stop managing the view (might be visible)
            unitLabel.removeFromSuperview() // Fully removes from view hierarchy and screen
        }
    }
    
    func amountTextValueChanged() -> UIAction {
        return UIAction { _ in
            self.delegate?.textFieldInputTableViewCell(self, textDidChange: self.amountTextField.text)
        }
    }
}
