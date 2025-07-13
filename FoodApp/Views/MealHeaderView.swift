//
//  MealHeaderView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/25/24.
//

import UIKit

class MealHeaderView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "MealHeaderView"
        
    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.textColor = Settings.shared.currentTheme.secondary.uiColor
        label.font = .preferredFont(forTextStyle: .caption1)
        return label
    }()
    
    var nutrientContainer: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.spacing = 6
        return container
    }()
    
    var container: UIStackView = {
        let container = UIStackView()
        container.axis = .horizontal
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let nutrientIds: [NutrientId] = [.calories, .carbs, .protein, .fatTotal]
    
    private lazy var nutrientsView: [NutrientView] = {
        return nutrientIds.map { _ in NutrientView() }
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        nutrientsView.forEach {
            nutrientContainer.addArrangedSubview($0)
        }

        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(nutrientContainer)

        contentView.addSubview(container)
//        container.layer.borderColor = UIColor.blue.cgColor
//        container.layer.borderWidth = 1

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
    
    func update(with meal: Meal) {
        titleLabel.text = meal.name.uppercased()
        
        for i in 0..<nutrientsView.count {
            let nutrientId = nutrientIds[i]
            let firstLetter = nutrientId.description.first!.lowercased()
            nutrientsView[i].update(
                amount: meal.nutrientAmount(nutrientId),
                unit: nutrientId.unitName,
                tintColor: UIColor(nutrientId.color)
            )
        }
        
        titleLabel.textColor = Settings.shared.currentTheme.label.uiColor
    }
}
