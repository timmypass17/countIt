//
//  SearchTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import UIKit

protocol ResultTableViewCellDelegate: AnyObject {
    func resultTableViewCell(_ cell: ResultTableViewCell, didAddFoodEntry foodEntry: FoodEntry)
}

protocol ResultTableViewCellHistoryDelegate: AnyObject {
    func resultTableViewCell(_ cell: ResultTableViewCell, didUpdateHistoryWithFood food: CDFood)
}

class ResultTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ResultCell"

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
    
    lazy var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.setContentHuggingPriority(.required, for: .horizontal)
        button.setContentCompressionResistancePriority(.required, for: .horizontal)
        button.addAction(didTapPlusButton(), for: .touchUpInside)

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
    
    var food: Food!
    var meal: Meal!
    
    weak var delegate: ResultTableViewCellDelegate?
    weak var historyDelegate: ResultTableViewCellHistoryDelegate?

    var selectedFoodPortion: FoodPortion {
        return food.foodPortions[(food.foodPortions.count - 1) / 2]
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        labelContainer.addArrangedSubview(titleLabel)
        labelContainer.addArrangedSubview(descriptionLabel)
        
        container.addArrangedSubview(labelContainer)
        container.addArrangedSubview(plusButton)
        
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
    
    func update(with food: Food) {
        self.food = food
        titleLabel.text = food.description
        descriptionLabel.text = food.getFoodEntryDescriptionFormatted(foodPortion: selectedFoodPortion)
    }
    
    func didTapPlusButton() -> UIAction {
        return UIAction { [self] _ in
            if let meal {
                let foodEntry = CoreDataStack.shared.addFoodEntry(food, to: meal, servingSize: selectedFoodPortion, numberOfServings: 1, servingSizeUnit: food.servingSizeUnit ?? "g")
                delegate?.resultTableViewCell(self, didAddFoodEntry: foodEntry)
                
                if let food = foodEntry.food {
                    food.updatedAt = .now
                    historyDelegate?.resultTableViewCell(self, didUpdateHistoryWithFood: food)
                }
            }
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }
    }
}
