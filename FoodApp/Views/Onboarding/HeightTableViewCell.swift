//
//  HeightTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/8/25.
//

import UIKit

class HeightTableViewCell: UITableViewCell {
    static let reuseIdentifier = "HeightTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let heightLabel: UILabel = {
        let label = UILabel()
        label.text = "Required"
        label.textColor = .secondaryLabel
        label.textAlignment = .right
        return label
    }()

    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .cellBackground

        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(heightLabel)
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

    
    func update(title: String, heightCm: Int16?, heightUnit: HeightUnit) {
        titleLabel.text = title
        if let heightCm {
            switch heightUnit {
            case .feet:
                let (feet, inches) = convertToFeetAndInches(cm: Int(heightCm))
                heightLabel.text = "\(feet) feet, \(inches) inches"
            case .cm:
                heightLabel.text = "\(heightCm) cm"
            }
        } else {
            heightLabel.text = "Required"
        }
    }
    
}
