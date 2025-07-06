//
//  MacroInputTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/11/25.
//

import UIKit

class MacroInputTableViewCell: UITableViewCell {

    static let reuseIdentifier = "MacroInputTableViewCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textColor = .secondaryLabel
        return label
    }()

    lazy var macroTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "0"
        textField.textAlignment = .right
        textField.keyboardType = .numberPad
        textField.addAction(weightTextFieldDidChange(), for: .editingChanged)
        return textField
    }()

    let unitLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.text = "g"
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

    private var editingChangedAction: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .cellBackground

        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(macroTextField)
        container.addArrangedSubview(unitLabel)
        contentView.addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 32),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(title: String, grams: Int16?, editingChangedAction: @escaping (String) -> Void) {
        titleLabel.text = title
        if let grams {
            macroTextField.text = "\(grams)"
        } else {
            macroTextField.text = nil
        }
        self.editingChangedAction = editingChangedAction
    }

    func weightTextFieldDidChange() -> UIAction {
        return UIAction { _ in
            self.editingChangedAction?(self.macroTextField.text ?? "")
        }
    }
}
