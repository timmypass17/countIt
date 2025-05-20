//
//  SearchTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import UIKit

protocol ResultTableViewCellDelegate: AnyObject {
    func resultTableViewCell(_ cell: ResultTableViewCell, didAddFoodEntry foodEntry: Food)
}

protocol ResultTableViewCellHistoryDelegate: AnyObject {
    func resultTableViewCell(_ cell: ResultTableViewCell, didUpdateHistoryWithFood food: Food)
}

class ResultTableViewCell: UITableViewCell {
    static let reuseIdentifier = "ResultCell"

    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.setContentHuggingPriority(.required, for: .horizontal)    // hug its content to never stretch
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)    // should shrink
//            .required (1000) on hugging means “do not grow beyond intrinsic size.”
//            .defaultLow (250) on titleLabel’s compression resistance means “if we must squeeze, let me truncate first.”
//            .required on the image view’s compression resistance means “never shrink the image”
        return label
    }()
    
    let checkmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.seal.fill")
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
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
    
    let titleContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    let labelContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var food: Food!
    var meal: Meal!
    
    weak var delegate: ResultTableViewCellDelegate?
    weak var historyDelegate: ResultTableViewCellHistoryDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        titleContainer.addArrangedSubview(titleLabel)
        titleContainer.addArrangedSubview(checkmarkImageView)
        titleContainer.addArrangedSubview(UIView())
        titleContainer.setCustomSpacing(8, after: titleLabel)
        
        labelContainer.addArrangedSubview(titleContainer)
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
    
//    func update<Item: FoodItem>(with foodItem: Item) {
    func update(with foodItem: FoodItem) {
//        self.food = food
        titleLabel.text = foodItem.description

        let foodPortion = foodItem.foodPortions[(foodItem.foodPortions.count - 1) / 2]
        descriptionLabel.text = foodItem.getFoodPortionDescription(foodPortion: foodPortion, numberOfServings: 1, options: FoodEntryOptions.allCases)
    }
    
    func didTapPlusButton() -> UIAction {
        return UIAction { [self] _ in
//            print(#function)
//            if let meal {
//                print("Has meal")
//                let foodEntry = CoreDataStack.shared.addFoodEntry(food, to: meal, servingSize: selectedFoodPortion, numberOfServings: 1, servingSizeUnit: food.servingSizeUnit ?? "g")
//                delegate?.resultTableViewCell(self, didAddFoodEntry: foodEntry)
//                
//                if let food = foodEntry.food {
//                    food.updatedAt = .now
//                    historyDelegate?.resultTableViewCell(self, didUpdateHistoryWithFood: food)
//                }
//            }
//            let generator = UIImpactFeedbackGenerator(style: .medium)
//            generator.impactOccurred()
        }
    }
}
