//
//  HeightCmPickerViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/10/25.
//

import UIKit

protocol HeightCmPickerViewControllerDelegate: AnyObject {
    func heightCmPickerViewController(_ viewController: HeightCmPickerViewController, didUpdateHeight heightCm: Int)
}

class HeightCmPickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    let cmData = Array(100...250)

    var selectedCm: Int
    weak var delegate: HeightCmPickerViewControllerDelegate?
    
    init(heightCm: Int) {
        self.selectedCm = heightCm
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
        
        if let index = cmData.firstIndex(of: selectedCm) {
            pickerView.selectRow(index, inComponent: 0, animated: false)
        }
    }

    func didTapDoneButton() -> UIAction {
        return UIAction { _ in
            self.selectedCm = self.cmData[self.pickerView.selectedRow(inComponent: 0)]
            self.delegate?.heightCmPickerViewController(self, didUpdateHeight: self.selectedCm)
            self.dismiss(animated: true)
        }
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return cmData.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(cmData[row]) cm"
    }
}
