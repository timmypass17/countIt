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
        label.textColor = .secondaryLabel
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
    
    var caloriesView: NutrientView = NutrientView()
    var carbsView: NutrientView = NutrientView()
    var proteinView: NutrientView = NutrientView()
    var fatsView: NutrientView = NutrientView()

//    init(meal: Meal) {
//        self.meal = meal
//        caloriesView = NutrientView(amount: meal.getTotalNutrients(.calories), unit: "cal", iconImage: UIImage(systemName: "c.circle"), tintColor: .systemBlue)
//        carbsView = NutrientView(amount: meal.getTotalNutrients(.carbs), unit: "g", iconImage: UIImage(systemName: "c.circle"), tintColor: .systemYellow)
//        proteinView = NutrientView(amount: meal.getTotalNutrients(.protein), unit: "g", iconImage: UIImage(systemName: "p.circle"), tintColor: .systemPink)
//        fatsView = NutrientView(amount: meal.getTotalNutrients(.totalFat), unit: "g", iconImage: UIImage(systemName: "f.circle"), tintColor: .systemGreen)
//
//        super.init(frame: .zero)
//        
//        titleLabel.text = meal.name.uppercased()
//        nutrientContainer.addArrangedSubview(caloriesView)
//        nutrientContainer.addArrangedSubview(carbsView)
//        nutrientContainer.addArrangedSubview(proteinView)
//        nutrientContainer.addArrangedSubview(fatsView)
//
//        
//        container.addArrangedSubview(titleLabel)
//        container.addArrangedSubview(nutrientContainer)
//        
//        self.addSubview(container)
//
//        NSLayoutConstraint.activate([
//            container.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
//            container.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
//            container.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
//            container.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
//        ])
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        nutrientContainer.addArrangedSubview(caloriesView)
        nutrientContainer.addArrangedSubview(carbsView)
        nutrientContainer.addArrangedSubview(proteinView)
        nutrientContainer.addArrangedSubview(fatsView)


        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(nutrientContainer)

        self.addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func update(with meal: Meal) {
        titleLabel.text = meal.name.uppercased()
        caloriesView.update(amount: meal.getTotalNutrients(.calories), unit: "cal", iconImage: UIImage(systemName: "c.circle"), tintColor: .systemBlue)
        carbsView.update(amount: meal.getTotalNutrients(.carbs), unit: "g", iconImage: UIImage(systemName: "c.circle"), tintColor: .systemYellow)
        proteinView.update(amount: meal.getTotalNutrients(.protein), unit: "g", iconImage: UIImage(systemName: "p.circle"), tintColor: .systemPink)
        fatsView.update(amount: meal.getTotalNutrients(.totalFat), unit: "g", iconImage: UIImage(systemName: "f.circle"), tintColor: .systemGreen)
    }
}
