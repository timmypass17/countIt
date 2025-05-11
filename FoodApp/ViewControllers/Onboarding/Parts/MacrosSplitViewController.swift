//
//  MacrosSplitViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/9/25.
//

import UIKit

protocol MacrosSplitViewControllerDelegate: AnyObject {
    func macrosSplitViewController(_ viewController: MacrosSplitViewController, didUpdateSplit split: (carbsPercent: Int, proteinPercent: Int, fatPercent: Int))
}

class MacrosSplitViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    let pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    let titleStackView: UIStackView = {
        let carbsLabel = UILabel()
        carbsLabel.text = "Carbs"
        carbsLabel.textAlignment = .center
        carbsLabel.font = .boldSystemFont(ofSize: 16)

        let proteinLabel = UILabel()
        proteinLabel.text = "Protein"
        proteinLabel.textAlignment = .center
        proteinLabel.font = .boldSystemFont(ofSize: 16)

        let fatLabel = UILabel()
        fatLabel.text = "Fat"
        fatLabel.textAlignment = .center
        fatLabel.font = .boldSystemFont(ofSize: 16)

        let stackView = UIStackView(arrangedSubviews: [carbsLabel, proteinLabel, fatLabel])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let percentageData = Array(0...100)

    var selectedCarbs: Int
    var selectedProtein: Int
    var selectedFat: Int
    
    init(selectedCarbs: Int, selectedProtein: Int, selectedFat: Int) {
        self.selectedCarbs = selectedCarbs
        self.selectedProtein = selectedProtein
        self.selectedFat = selectedFat
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var delegate: MacrosSplitViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Macro Split"
        navigationItem.largeTitleDisplayMode = .inline
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .done, primaryAction: didTapDoneButton())

        pickerView.dataSource = self
        pickerView.delegate = self
        
        view.addSubview(titleStackView)
        view.addSubview(pickerView)

        NSLayoutConstraint.activate([
            titleStackView.leadingAnchor.constraint(equalTo: pickerView.leadingAnchor),
            titleStackView.trailingAnchor.constraint(equalTo: pickerView.trailingAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: pickerView.topAnchor, constant: -8),

            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        pickerView.selectRow(selectedCarbs, inComponent: 0, animated: false)
        pickerView.selectRow(selectedProtein, inComponent: 1, animated: false)
        pickerView.selectRow(selectedFat, inComponent: 2, animated: false)
    }

    func didTapDoneButton() -> UIAction {
        return UIAction { _ in
            let carbs = self.percentageData[self.pickerView.selectedRow(inComponent: 0)]
            let protein = self.percentageData[self.pickerView.selectedRow(inComponent: 1)]
            let fat = self.percentageData[self.pickerView.selectedRow(inComponent: 2)]

            if carbs + protein + fat != 100 {
                let alert = UIAlertController(title: "Invalid Split", message: "Total must equal 100%.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self.present(alert, animated: true)
                return
            }

            self.delegate?.macrosSplitViewController(self, didUpdateSplit: (carbs, protein, fat))
            self.dismiss(animated: true)
        }
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return percentageData.count
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let label = percentageData[row]
        return "\(label)%"
    }
}
