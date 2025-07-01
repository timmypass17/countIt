//
//  UpdateNutrientTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/1/25.
//

import UIKit

protocol UpdateNutrientTableViewCellDelegate: AnyObject {
    func updateNutrientTableViewCell(_ sender: UpdateNutrientTableViewCell, amountTextValueChanged amountText: String?)
}

class UpdateNutrientTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "UpdateNutrientTableViewCell"
    
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

    weak var delegate: UpdateNutrientTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
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
    
    func update(primaryText: String, amount: Double?, initialAmount: Double, unit: String) {
        titleLabel.text = primaryText
        if let amount {
            amountTextField.text = amount.trimmed
        } else {
            amountTextField.text = nil
        }
        amountTextField.placeholder = initialAmount.trimmed
        unitLabel.text = unit
    }
    
    func amountTextValueChanged() -> UIAction {
        return UIAction { _ in
            self.delegate?.updateNutrientTableViewCell(self, amountTextValueChanged: self.amountTextField.text)
        }
    }
}
