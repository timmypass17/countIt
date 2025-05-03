//
//  IngredientTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/2/25.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    static let reuseIdentifier = "IngredientTableViewCell"
    
    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        container.addArrangedSubview(nameLabel)
        container.addArrangedSubview(descriptionLabel)
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(ingredient: FDCFoodInput) {
        nameLabel.text = ingredient.name
        descriptionLabel.text = ingredient.portionDescription
    }
}
