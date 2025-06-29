//
//  HomeTitleView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import UIKit

protocol MealPlanDateViewDelegate: AnyObject {
    func mealPlanDateViewDelegate(_ sender: MealPlanDateView, datePickerValueChanged date: Date)
    func mealPlanDateViewDelegate(_ sender: MealPlanDateView, didTapDateButton date: Date)
}

class MealPlanDateView: UIView {
    
    var selectedDate: Date {
        didSet {
            updateDateText()
        }
    }
    
    weak var delegate: MealPlanDateViewDelegate?
    
    lazy var dateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Today", for: .normal)
        button.addAction(didTapDateButton(), for: .touchUpInside)
        return button
    }()
    
    var previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .label
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .label
        button.widthAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    var container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(date: Date) {
        self.selectedDate = date
//        datePicker.addAction(datePickerValueChanged(), for: .valueChanged)
        super.init(frame: .zero)
        previousButton.addAction(didTapPreviousButton(), for: .touchUpInside)
        nextButton.addAction(didTapNextButton(), for: .touchUpInside)

        container.addArrangedSubview(previousButton)
//        container.addArrangedSubview(datePicker)
        container.addArrangedSubview(dateButton)
        container.addArrangedSubview(nextButton)
        self.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            container.leadingAnchor.constraint(equalTo: leadingAnchor),
            container.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapDateButton() -> UIAction {
        return UIAction { _ in
            self.delegate?.mealPlanDateViewDelegate(self, didTapDateButton: self.selectedDate)
        }
    }
    
    func datePickerValueChanged() -> UIAction {
        return UIAction { [self] _ in
            delegate?.mealPlanDateViewDelegate(self, datePickerValueChanged: selectedDate)
        }
    }
    
    func didTapNextButton() -> UIAction {
        return UIAction { [self] _ in
            selectedDate = Calendar.current.date(byAdding: .day, value: 1, to: selectedDate)!
            
            delegate?.mealPlanDateViewDelegate(self, datePickerValueChanged: selectedDate)
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
    
    func didTapPreviousButton() -> UIAction {
        return UIAction { [self] _ in
            selectedDate = Calendar.current.date(byAdding: .day, value: -1, to: selectedDate)!
            delegate?.mealPlanDateViewDelegate(self, datePickerValueChanged: selectedDate)
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
    
    func updateDateText() {
        if Calendar.current.isDateInToday(selectedDate) {
            dateButton.setTitle("Today", for: .normal)
        } else if Calendar.current.isDateInTomorrow(selectedDate) {
            dateButton.setTitle("Tomorrow", for: .normal)
        } else if Calendar.current.isDateInYesterday(selectedDate) {
            dateButton.setTitle("Yesterday", for: .normal)
        } else {
            dateButton.setTitle(selectedDate.formatted(date: .abbreviated, time: .omitted), for: .normal)
        }
    }
}
