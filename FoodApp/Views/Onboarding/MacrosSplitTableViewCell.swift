//
//  MacrosSplitTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/9/25.
//

import UIKit

class MacroSplitTableViewCell: UITableViewCell {
    static let reuseIdentifier = "MacroSplitTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Macro Split"
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let macroSplitLabel: UILabel = {
        let label = UILabel()
        label.text = "40/40/20"
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
        
        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(macroSplitLabel)
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

    
    func update(carbs: Int16, proteins: Int16, fats: Int16) {
        macroSplitLabel.text = "\(carbs)/\(proteins)/\(fats)"
    }
    
}
