//
//  SearchTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    static let reuseIdentifier = "SearchCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "plus"), for: .normal)
        return button
    }()
    
    let labelContainer: UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .vertical
        return hstack
    }()
    
    let container: UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.translatesAutoresizingMaskIntoConstraints = false
        return hstack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        labelContainer.addArrangedSubview(titleLabel)
        labelContainer.addArrangedSubview(descriptionLabel)
        
        container.addArrangedSubview(labelContainer)
        container.addArrangedSubview(plusButton)
        
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with model: ResultsTableViewController.Model) {
        titleLabel.text = model.foodSearchResults.getNameFormatted()
        descriptionLabel.text = getDescriptionFormatted(model: model)
    }
    
    private func getDescriptionFormatted(model: ResultsTableViewController.Model) -> String {
        let foodSearchResult = model.foodSearchResults
        let food = model.food
        if model.food.foodPortions == nil || model.food.foodPortions!.isEmpty {
            return [foodSearchResult.getCaloriesFormatted(), foodSearchResult.getServingSizeFormatted(), foodSearchResult.getBrandNameFormatted()]
                .compactMap { $0 }
                .joined(separator: ", ")
        } else {
            return [food.getCaloriesFormatted(), food.getServingSizeFormatted(), foodSearchResult.getBrandNameFormatted()]
                .compactMap { $0 }
                .joined(separator: ", ")
        }
    }
}
