//
//  SelectTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/5/24.
//

import UIKit

protocol GoalTableViewCellDelegate: AnyObject {
    func goalTableViewCell(_ cell: GoalTableViewCell, amountValueChanged: String)
}

class GoalTableViewCell: UITableViewCell {
    static let reuseIdentifier = "GoalCell"

    var primaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    var amountTextField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
//        textField.placeholder = "0"
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    var unitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        return label
    }()

    var container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var toolbar: UIToolbar = {
        let bar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDoneButton))
        bar.items = [.flexibleSpace(), doneButton]
        bar.sizeToFit()
        return bar
    }()
    
    var nutrientID: NutrientId!
    weak var delegate: GoalTableViewCellDelegate?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        amountTextField.rightView = unitLabel
        amountTextField.rightViewMode = .always
        amountTextField.inputAccessoryView = toolbar
        
        amountTextField.addAction(amountTextFieldEditingChanged(), for: .editingChanged)
        
        container.addArrangedSubview(primaryLabel)
        container.addArrangedSubview(amountTextField)
        
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
    
    func update(nutrientID: NutrientId, goal: Int) {
        self.nutrientID = nutrientID
        primaryLabel.text = nutrientID.description
        amountTextField.text = "\(goal)"
        amountTextField.placeholder = "\(goal)"
//        unitLabel.text = nutrientID.unit
    }
    
    func amountTextFieldEditingChanged() -> UIAction {
        return UIAction { _ in
            // delegate. Enable/disable done button if empty
            self.delegate?.goalTableViewCell(self, amountValueChanged: self.amountTextField.text ?? "")
        }
    }
    
    @objc func didTapDoneButton() {
        endEditing(true)
    }
}
