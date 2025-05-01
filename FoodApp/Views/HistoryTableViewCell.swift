//
//  SearchTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/21/24.
//

import UIKit

protocol HistoryTableViewCellDelegate: AnyObject {
    func historyTableViewCell(_ cell: HistoryTableViewCell, didDeleteFood food: Food)
}

class HistoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "HistoryCell"

    var cdFood: Food!
    weak var delegate: HistoryTableViewCellDelegate?

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .secondaryLabel
        return label
    }()
    
    let deleteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .secondaryLabel
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])

        return button
    }()
    
    let labelContainer: UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .vertical
        return hstack
    }()
    
    let container: UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.translatesAutoresizingMaskIntoConstraints = false
        return hstack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        deleteButton.addAction(deleteButtonTapped(), for: .touchUpInside)
        
        labelContainer.addArrangedSubview(titleLabel)
        labelContainer.addArrangedSubview(descriptionLabel)
        
        container.addArrangedSubview(labelContainer)
        container.addArrangedSubview(deleteButton)
        
        contentView.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with cdFood: Food) {
        self.cdFood = cdFood
//        let food = cdFood.convertToFDCFood()
//        titleLabel.text = "\(food.description)"
//        descriptionLabel.text = food.getDescriptionFormatted(foodPortion: food.foodPortions[(food.foodPortions.count - 1) / 2])
//        descriptionLabel.text = food.getFoodEntryDescriptionFormatted(foodPortion: food.foodPortions[(food.foodPortions.count - 1) / 2])
    }
    
    func deleteButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            CoreDataStack.shared.deleteHistory(cdFood)
            delegate?.historyTableViewCell(self, didDeleteFood: cdFood)
        }
    }
}
