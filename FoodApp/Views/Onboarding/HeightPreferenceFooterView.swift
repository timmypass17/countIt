//
//  HeightPreferenceFooterView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/9/25.
//

import UIKit

protocol HeightPreferenceFooterViewDelegate: AnyObject {
    func heightPreferenceFooterView(_ footerView: HeightPreferenceFooterView, didUpdateHeightPreference heightUnit: HeightUnit)
}

class HeightPreferenceFooterView: UITableViewHeaderFooterView {
    static let reuseIdentifier = "HeightPreferenceFooterView"
    
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
    
    weak var delegate: HeightPreferenceFooterViewDelegate?
    
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
    
    func update(heightUnit: HeightUnit) {
        unitSwitchButton.removeAction(didTapUnitButton(heightUnit: .feet), for: .touchUpInside)
        unitSwitchButton.removeAction(didTapUnitButton(heightUnit: .cm), for: .touchUpInside)

        switch heightUnit {
        case .feet:
            unitSwitchButton.setTitle("Use cm instead", for: .normal)
            unitSwitchButton.addAction(didTapUnitButton(heightUnit: .cm), for: .touchUpInside)
        case .cm:
            unitSwitchButton.setTitle("Use ft instead", for: .normal)
            unitSwitchButton.addAction(didTapUnitButton(heightUnit: .feet), for: .touchUpInside)
        }
    }
    
    func didTapUnitButton(heightUnit: HeightUnit) -> UIAction {
        return UIAction { [weak self] _ in
            guard let self else { return }
            self.delegate?.heightPreferenceFooterView(self, didUpdateHeightPreference: heightUnit)
            self.update(heightUnit: heightUnit)
        }
    }
}
