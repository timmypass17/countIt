//
//  QuickAddTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 4/3/24.
//

import UIKit

protocol QuickAddTableViewCellDelegate: AnyObject {
    func quickAddTableViewCell(_ cell: QuickAddTableViewCell, textFieldValueChanged text: String?)
}

class QuickAddTableViewCell: UITableViewCell {
    static let reuseIdentifier = "QuickAddCell"

    var primaryLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    var textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
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
    
    weak var delegate: QuickAddTableViewCellDelegate?
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        textField.rightView = unitLabel
        textField.rightViewMode = .always
        textField.inputAccessoryView = toolbar
        
        container.addArrangedSubview(primaryLabel)
        container.addArrangedSubview(textField)
        
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
        
        textField.addAction(textFieldValueChanged(), for: .editingChanged)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(title: String?) {
        primaryLabel.text = "Name*"
        textField.text = title
        textField.placeholder = "Banana"
    }
    
    func update(foodNutrient: FoodInfoNutrient) {
        primaryLabel.text = foodNutrient.nutrientId?.description

        if let amount = foodNutrient.value {
            textField.text = String(amount)
        } 
        unitLabel.text = foodNutrient.nutrientId?.unitName
        textField.placeholder = "0"
    }
    
    func textFieldValueChanged() -> UIAction {
        return UIAction { [self] _ in
            delegate?.quickAddTableViewCell(self, textFieldValueChanged: textField.text)
        }
    }

    @objc func didTapDoneButton() {
        endEditing(true)
    }
}
