//
//  HeightPickerViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/8/25.
//

import UIKit

protocol HeightFeetPickerViewControllerDelegate: AnyObject {
    func heightFeetPickerViewController(_ viewController: HeightFeetPickerViewController, didUpdateHeight height: (feet: Int, inches: Int))
}

class HeightFeetPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    let feetData = Array(1...8)
    let inchesData = Array(0...11)
    
    var selectedFeet: Int
    var selectedInches: Int
    weak var delegate: HeightFeetPickerViewControllerDelegate?
    
    init(heightCm: Int) {
        let (feet, inches) = convertToFeetAndInches(cm: heightCm)
        self.selectedFeet = feet
        self.selectedInches = inches
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        navigationItem.title = "Height"
        navigationItem.largeTitleDisplayMode = .inline
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: didTapDoneButton())

        pickerView.dataSource = self
        pickerView.delegate = self
        view.addSubview(pickerView)

        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        if let feetIndex = feetData.firstIndex(of: selectedFeet),
           let inchesIndex = inchesData.firstIndex(of: selectedInches) {
            pickerView.selectRow(feetIndex, inComponent: 0, animated: false)
            pickerView.selectRow(inchesIndex, inComponent: 1, animated: false)
        }
    }

    func didTapDoneButton() -> UIAction {
        return UIAction { _ in
            self.selectedFeet = self.feetData[self.pickerView.selectedRow(inComponent: 0)]
            self.selectedInches = self.inchesData[self.pickerView.selectedRow(inComponent: 1)]
            self.delegate?.heightFeetPickerViewController(self, didUpdateHeight: (self.selectedFeet, self.selectedInches))
            self.dismiss(animated: true)
        }
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? feetData.count : inchesData.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? "\(feetData[row]) ft" : "\(inchesData[row]) in"
    }
}

func convertToCentimeters(feet: Int, inches: Int) -> Int {
    let totalInches = (feet * 12) + inches
    let centimeters = Double(totalInches) * 2.54
    return Int(round(centimeters))
}

func convertToFeetAndInches(cm: Int) -> (feet: Int, inches: Int) {
    let totalInches = Double(cm) / 2.54
    let feet = Int(totalInches / 12)
    let inches = Int(round(totalInches.truncatingRemainder(dividingBy: 12)))
    
    // Handle case where inches round up to 12
    if inches == 12 {
        return (feet + 1, 0)
    }
    
    return (feet, inches)
}
