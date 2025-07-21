//
//  UnitPreferenceFooterView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/9/25.
//

import UIKit

protocol UnitPreferenceFooterViewDelegate: AnyObject {
    func unitPreferenceFooterView(_ footerView: UnitPreferenceFooterView, didUpdateUnitPreference unit: WeightUnit)
}

class UnitPreferenceFooterView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "UnitPreferenceFooterView"
    
    lazy var unitSwitchButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.secondaryLabel, for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .footnote)
        return button
    }()
    
    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    weak var delegate: UnitPreferenceFooterViewDelegate?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        container.addArrangedSubview(UIView())
        container.addArrangedSubview(unitSwitchButton)
        contentView.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func update(currentUnit: WeightUnit) {
        unitSwitchButton.removeAction(didTapUnitButton(newUnit: .pounds), for: .touchUpInside)
        unitSwitchButton.removeAction(didTapUnitButton(newUnit: .kilograms), for: .touchUpInside)

        switch currentUnit {
        case .pounds:
            unitSwitchButton.setTitle("Use kg instead", for: .normal)
            unitSwitchButton.addAction(didTapUnitButton(newUnit: .kilograms), for: .touchUpInside)
        case .kilograms:
            unitSwitchButton.setTitle("Use lb instead", for: .normal)
            unitSwitchButton.addAction(didTapUnitButton(newUnit: .pounds), for: .touchUpInside)
        }
    }
    
    func didTapUnitButton(newUnit: WeightUnit) -> UIAction {
        return UIAction { _ in
            self.delegate?.unitPreferenceFooterView(self, didUpdateUnitPreference: newUnit)
            self.update(currentUnit: newUnit)
        }
    }
}
