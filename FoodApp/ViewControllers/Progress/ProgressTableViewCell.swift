//
//  ProgressTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/27/25.
//

import UIKit
import SwiftUI

class ProgressTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ProgressTableViewCell"
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .bold)
        label.adjustsFontSizeToFitWidth = true         // allow shrinking
        label.minimumScaleFactor = 0.5                  // shrink down to 50% of original size
        label.lineBreakMode = .byTruncatingTail         // optional: truncate if still too long
        label.numberOfLines = 1                         // important: must be 1 for shrinking to work
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let symbolImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 20),
            imageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        return imageView
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title1).pointSize, weight: .semibold)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
//    let unitLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .secondaryLabel
//        label.font = .preferredFont(forTextStyle: .caption1)
//        return label
//    }()
    
    let goalLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: UIFont.preferredFont(forTextStyle: .title3).pointSize)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()
    
    let titleContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()
    
    let amountContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.alignment = .bottom
        stackView.alignment = .lastBaseline
        return stackView
    }()
    
    let vstack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
//        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var hostingController: UIHostingController<WeeklyNutrientChartView>!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        hostingController = UIHostingController(rootView: WeeklyNutrientChartView(data: [], goal: 0, color: .accentColor))
        hostingController.view.backgroundColor = .clear
        

//        unitContainer.addArrangedSubview(unitLabel)
//        unitContainer.addArrangedSubview(goalLabel)

        amountContainer.addArrangedSubview(amountLabel)
        amountContainer.addArrangedSubview(goalLabel)
        amountContainer.addArrangedSubview(UIView())

        titleContainer.addArrangedSubview(symbolImageView)
        titleContainer.addArrangedSubview(titleLabel)
        
        vstack.addArrangedSubview(titleContainer)
        vstack.addArrangedSubview(UIView())
        vstack.addArrangedSubview(amountContainer)
        
        container.addArrangedSubview(vstack)
        container.addArrangedSubview(UIView())
        container.addArrangedSubview(hostingController.view)
        
        contentView.addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
        ])
        
        backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor
        accessoryType = .disclosureIndicator
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(title: String, date: Date, amount: Double, unit: String, data: [WeeklyData], goal: Double, color: Color, icon: String) {

        titleLabel.text = title
        symbolImageView.image = UIImage(systemName: icon)
        symbolImageView.tintColor = UIColor(color)
        amountLabel.text = amount.trimmed
//        unitLabel.text = unit
        goalLabel.text = "/ \(goal.trimmed) \(unit)"
        
        hostingController.rootView.data = data
        hostingController.rootView.goal = goal
        hostingController.rootView.color = color
        titleLabel.textColor = UIColor(color)
        
        backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor
        amountLabel.textColor = Settings.shared.currentTheme.label.uiColor
        goalLabel.textColor = Settings.shared.currentTheme.secondary.uiColor
    }
}
