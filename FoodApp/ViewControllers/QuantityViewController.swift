//
//  QuantityViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/8/24.
//

import UIKit

protocol QuantityTableViewControllerDelegate: AnyObject {
    func quantityTableViewController(_ sender: QuantityViewController, didSelectQuantity quantity: Int)
}

class QuantityViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    var selectedQuantity: Int
    weak var delegate: QuantityTableViewControllerDelegate?
    
    init(selectedQuantity: Int) {
        self.selectedQuantity = selectedQuantity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.selectRow(selectedQuantity - 1, inComponent: 0, animated: true)
        
        title = "Number of Servings"
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: doneButtonTapped())
        navigationItem.leftBarButtonItem = UIBarButtonItem(systemItem: .cancel, primaryAction: cancelButtonTapped())

        view.backgroundColor = UIColor.systemBackground

        view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            pickerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 99
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func doneButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            let quantity = pickerView.selectedRow(inComponent: 0) + 1
            delegate?.quantityTableViewController(self, didSelectQuantity: quantity)
            dismiss(animated: true)
        }
    }
    
    func cancelButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            dismiss(animated: true)
        }
    }
    
}
