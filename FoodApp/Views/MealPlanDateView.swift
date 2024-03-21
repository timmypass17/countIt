//
//  HomeTitleView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import UIKit

protocol MealPlanDateViewDelegate: AnyObject {
    func mealPlanDateViewDelegate(_ sender: MealPlanDateView, datePickerValueChanged date: Date)

}

class MealPlanDateView: UIView {
    
    var selectedDate: Date {
        return Calendar.current.startOfDay(for: datePicker.date)
    }
    
    weak var delegate: MealPlanDateViewDelegate?
    
    var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .compact
        return picker
    }()
    
    var previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    var container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        datePicker.addAction(datePickerValueChanged(), for: .valueChanged)
        previousButton.addAction(didTapPreviousButton(), for: .touchUpInside)
        nextButton.addAction(didTapNextButton(), for: .touchUpInside)

        container.addArrangedSubview(previousButton)
        container.addArrangedSubview(datePicker)
        container.addArrangedSubview(nextButton)
        self.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func datePickerValueChanged() -> UIAction {
        return UIAction { [self] _ in
            delegate?.mealPlanDateViewDelegate(self, datePickerValueChanged: selectedDate)
        }
    }
    
    func didTapNextButton() -> UIAction {
        return UIAction { [self] _ in
            datePicker.date = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
            delegate?.mealPlanDateViewDelegate(self, datePickerValueChanged: selectedDate)
        }
    }
    
    func didTapPreviousButton() -> UIAction {
        return UIAction { [self] _ in
            datePicker.date = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
            delegate?.mealPlanDateViewDelegate(self, datePickerValueChanged: selectedDate)
        }
    }
}
