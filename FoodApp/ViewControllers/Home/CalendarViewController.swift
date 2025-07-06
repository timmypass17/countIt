//
//  CalendarViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/20/24.
//

import UIKit

protocol CalendarViewControllerDelegate: AnyObject {
    func calendarViewController(_ sender: CalendarViewController, didSelectDate date: Date)
}

class CalendarViewController: UIViewController {
    
    var date: Date
    weak var delegate: CalendarViewControllerDelegate?
    
    var selectedDate: Date {
        return Calendar.current.startOfDay(for: datePicker.date)
    }
    
    init(date: Date) {
        self.date = date
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .inline
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Select Meal Plan Date to Copy"
        datePicker.date = date
        view.backgroundColor = .systemBackground
        
        let cancelAction = UIAction { _ in
            self.navigationController?.dismiss(animated: true)
        }
        let doneAction = UIAction { [self] _ in
            navigationController?.dismiss(animated: true)
            delegate?.calendarViewController(self, didSelectDate: selectedDate)
        }

        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelAction)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Confirm", primaryAction: doneAction)

        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: -25)
        ])
        
    }
}
