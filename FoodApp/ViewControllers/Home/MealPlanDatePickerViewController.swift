//
//  MealPlanDatePickerViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/26/25.
//

import UIKit

protocol MealPlanDatePickerViewControllerDelegate: AnyObject {
    func mealPlanDatePickerViewControllerDelegate(_ viewController: MealPlanDatePickerViewController, didSelectDate date: Date)
}

class MealPlanDatePickerViewController: UIViewController {
    
    lazy var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.locale = .current
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.addAction(didTapDate(), for: .valueChanged)
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    weak var delegate: MealPlanDatePickerViewControllerDelegate?
    
    init(date: Date) {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .background
        title = "Select a Date"
        datePicker.date = date

        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            datePicker.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            datePicker.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func didTapDate() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self = self else { return }
            self.delegate?.mealPlanDatePickerViewControllerDelegate(self, didSelectDate: self.datePicker.date)
        }
    }
}
