//
//  OnboardingSegmentedTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/8/25.
//

import UIKit

protocol OnboardingSegmentedTableViewCellDelegate: AnyObject {
    func onboardingSegmentedTableViewCell(_ cell: OnboardingSegmentedTableViewCell, didSelectSex sex: Sex)
}

class OnboardingSegmentedTableViewCell: UITableViewCell {
    static let reuseIdentifier = "OnboardingSegmentedTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var genderSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: Sex.allCases.map { $0.description })
        control.selectedSegmentIndex = UISegmentedControl.noSegment
        control.setContentHuggingPriority(.required, for: .horizontal)
        control.setContentCompressionResistancePriority(.required, for: .horizontal)
        control.widthAnchor.constraint(equalToConstant: 180).isActive = true
        control.addAction(didSelectSex(), for: .valueChanged)
        return control
    }()

    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    weak var delegate: OnboardingSegmentedTableViewCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(genderSegmentedControl)
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func update(title: String, sex: Sex?) {
        titleLabel.text = title
        
        if let sex, let index = Sex.allCases.firstIndex(of: sex) {
            genderSegmentedControl.selectedSegmentIndex = index
        }
    }
    
    func didSelectSex() -> UIAction {
        return UIAction { _ in
            let index = self.genderSegmentedControl.selectedSegmentIndex
            let selectedGender = Sex.allCases[index]
            self.delegate?.onboardingSegmentedTableViewCell(self, didSelectSex: selectedGender)
        }
    }
}
