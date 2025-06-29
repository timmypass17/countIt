//
//  SearchTitleView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/21/24.
//

import UIKit

protocol SearchTitleViewDelegate: AnyObject {
    func searchTitleView(_ sender: SearchTitleView, didSelectMeal meal: Meal)
}

class SearchTitleView: UIView {
    var selectedMeal: Meal
    let meals: [Meal]
    
    weak var delegate: SearchTitleViewDelegate?
    
    var mealButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        var imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .regular, scale: .default)
        imageConfig = imageConfig.applying(UIImage.SymbolConfiguration(hierarchicalColor: .white))
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "chevron.up.chevron.down", withConfiguration: imageConfig)
        config.imagePadding = 4
        config.imagePlacement = .trailing
        button.configuration = config
        button.showsMenuAsPrimaryAction = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    init(selectedMeal: Meal,  meals: [Meal]) {
        self.selectedMeal = selectedMeal
        self.meals = meals
        super.init(frame: .zero)
        
        var actions: [UIAction] = []
        for meal in meals {
            actions.append(didTapMenuOption(for: meal))
        }
        
        mealButton.menu = UIMenu(title: getMealButtonTitle(date: selectedMeal.mealPlan?.date), options: .singleSelection, children: actions)
        
        addSubview(mealButton)
        
        NSLayoutConstraint.activate([
            mealButton.topAnchor.constraint(equalTo: topAnchor),
            mealButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            mealButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            mealButton.trailingAnchor.constraint(equalTo: trailingAnchor),

        ])
        
        updateUI()
    }
    
    func getMealButtonTitle(date: Date?) -> String {
        guard let date else { return "" }
        if Calendar.current.isDateInToday(date) {
            return "Today"
        } else if Calendar.current.isDateInTomorrow(date) {
            return "Tomorrow"
        } else if Calendar.current.isDateInYesterday(date) {
            return "Yesterday"
        } else {
            return date.formatted(date: .abbreviated, time: .omitted)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateUI() {
        mealButton.setTitle(selectedMeal.name, for: .normal)
    }
    
    func didTapMenuOption(for meal: Meal) -> UIAction {
        let isSelected = meal == selectedMeal
        let state: UIMenuElement.State = isSelected ? .on : .off
        return UIAction(title: meal.name, state: state,  handler: { [self] _ in
            selectedMeal = meal
            delegate?.searchTitleView(self, didSelectMeal: selectedMeal)
            updateUI()
        })
    }

}
