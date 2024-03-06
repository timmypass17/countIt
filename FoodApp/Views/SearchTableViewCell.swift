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
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
//        button.backgroundColor = .gray
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
//        hstack.backgroundColor = .orange
        return hstack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        labelContainer.addArrangedSubview(titleLabel)
        labelContainer.addArrangedSubview(descriptionLabel)
        
        container.addArrangedSubview(labelContainer)
        container.addArrangedSubview(plusButton)
        
        contentView.addSubview(container)
        
//        labelContainer.backgroundColor = .blue

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
    
    func update(with model: FoodItem) {
        titleLabel.text = model.foodSearchResults.getNameFormatted()
        descriptionLabel.text = getDescriptionFormatted(model: model)
    }
    
    private func getDescriptionFormatted(model: FoodItem) -> String {
        let foodSearchResult = model.foodSearchResults
        let food = model.food
        if foodSearchResult.servingSize != nil {
            return [model.getCaloriesPerServingFormatted(), foodSearchResult.getServingSizeFormatted(), foodSearchResult.getBrandNameFormatted()/*, "[1]"*/]
                .compactMap { $0 }
                .joined(separator: ", ")
        } else if food.foodPortions.count > 0 {
            return [model.getCaloriesPerServingFormatted(), food.averageFoodPortionSize.getServingSizeFormatted(), foodSearchResult.getBrandNameFormatted()/*, "[2]"*/]
                .compactMap { $0 }
                .joined(separator: ", ")
        } else {
            return "Error description"
        }
        
//        if model.food.foodPortions.count == 1 {
//            return [foodSearchResult.getCaloriesFormatted(), "100 g", foodSearchResult.getBrandNameFormatted(), "Only has 100g"]
//                .compactMap { $0 }
//                .joined(separator: ", ")
//        } else {
//            return [food.getCaloriesFormatted(), food.foodPortions.first?.getServingSizeFormatted(), foodSearchResult.getBrandNameFormatted()]
//                .compactMap { $0 }
//                .joined(separator: ", ")
//        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    let cell = SearchTableViewCell()
    cell.update(with: FoodItem.sample)
    NSLayoutConstraint.activate([
        cell.heightAnchor.constraint(equalToConstant: 60)
    ])
    cell.layer.borderWidth = 1
    cell.layer.borderColor = UIColor.blue.cgColor
            
    return cell
}

extension FoodItem {
    static let sample = FoodItem(
        foodSearchResults: FoodSearchResults(fdcId: 0, description: "Banana", foodNutrients: [], foodMeasures: []),
        food: Food(foodNutrients: [FoodNutrient(nutrient: Nutrient(name: "Calories", unitName: "kcal"), amount: 89)], foodPortions: [FoodPortion(portionDescription: "", amount: 1, gramWeight: 118, modifier: "medium (7\" to 7-7/8\" long)")], servingSizeUnit: "g"))
}
