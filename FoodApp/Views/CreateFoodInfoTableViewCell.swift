//
//  CreateFoodInfoTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/20/25.
//

import UIKit

class CreateFoodInfoTableViewCell: UITableViewCell {

    static let reuseIdentifier = "CreateFoodInfoTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let secondaryLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textAlignment = .right
        textField.addAction(textFieldDidChange(), for: .editingChanged)
        return textField
    }()
    
    let labelContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    var editingChangedAction: ((String?) -> Void)?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(hex: "#252525")

        labelContainer.addArrangedSubview(titleLabel)
        labelContainer.addArrangedSubview(secondaryLabel)
        
        container.addArrangedSubview(labelContainer)
        container.addArrangedSubview(textField)
        
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
    
    func update(title: String, description: String, placeholderText: String, editingChangedAction: @escaping (String?) -> Void) {
        titleLabel.text = title
        secondaryLabel.text = description
        textField.placeholder = placeholderText
        self.editingChangedAction = editingChangedAction
    }
    
    func textFieldDidChange() -> UIAction {
        return UIAction { _ in
            self.editingChangedAction?(self.textField.text)
        }
    }
}
