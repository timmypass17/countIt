
//
//  WeightInputTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/7/25.
//

import UIKit

class WeightInputTableViewCell: UITableViewCell {

    static let reuseIdentifier = "WeightInputTableViewCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    lazy var weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Required"
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        textField.addAction(weightTextFieldDidChange(), for: .editingChanged)
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

    private var editingChangedAction: ((String) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(weightTextField)
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

    func update(title: String, unit: WeightUnit, weightKg: Double?, editingChangedAction: @escaping (String) -> Void) {
        titleLabel.text = title
        unitLabel.text = unit.shortSymbol
        if let weightKg {
            switch unit {
            case .pounds:
                weightTextField.text = convertKilogramsToPounds(weightKg).trimmed
            case .kilograms:
                weightTextField.text = weightKg.trimmed
            }
        } else {
            weightTextField.text = nil
        }
        
        self.editingChangedAction = editingChangedAction
    }

    func weightTextFieldDidChange() -> UIAction {
        return UIAction { _ in
            self.editingChangedAction?(self.weightTextField.text ?? "")
        }
    }
}
