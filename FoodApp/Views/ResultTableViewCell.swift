//
//  SearchTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/2/24.
//

import UIKit

protocol ResultTableViewCellDelegate: AnyObject {
    func resultTableViewCell(_ cell: ResultTableViewCell, didTapAddButton: Bool)
}

class ResultTableViewCell: UITableViewCell {
    
    class var reuseIdentifier: String {
        return "ResultTableViewCell"
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        label.font = UIFont.boldSystemFont(ofSize: 16.0)
        label.setContentHuggingPriority(.required, for: .horizontal)    // hug its content to never stretch
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)    // should shrink
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
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
        button.tintColor = .secondaryLabel
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
        
    weak var delegate: ResultTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor

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
    
    func update(with foodItem: FoodItem) {
        titleLabel.text = foodItem.description
        descriptionLabel.text = foodItem.getFoodPortionDescription(foodPortion: foodItem.selectedFoodPortion, numberOfServings: 1, options: FoodEntryOptions.allCases)
        
    }
    
    func didTapPlusButton() -> UIAction {
        return UIAction { [weak self] _ in
            guard let self else { return }

            // Haptic feedback
            UIImpactFeedbackGenerator(style: .medium).impactOccurred()

            // Swap image to checkmark
            UIView.transition(with: self.plusButton, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.plusButton.setImage(UIImage(systemName: "checkmark.circle.fill"), for: .normal)
                self.plusButton.tintColor = Settings.shared.currentTheme.label.uiColor
            })

            // Grow big
            UIView.animate(withDuration: 0.25, animations: {
                self.plusButton.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: { _ in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // pause for 0.5 seconds
                    // Shrink back to original
                    UIView.animate(withDuration: 0.25) {
                        self.plusButton.transform = .identity
                    } completion: { _ in
                        UIView.transition(with: self.plusButton, duration: 0.15, options: .transitionCrossDissolve, animations: {
                            self.plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
                            self.plusButton.tintColor = Settings.shared.currentTheme.secondary.uiColor
                        })
                    }
                    
                    self.plusButton.isUserInteractionEnabled = true
                }
            })

            // Disable button temporarily
            self.plusButton.isUserInteractionEnabled = false

            // Notify delegate
            delegate?.resultTableViewCell(self, didTapAddButton: true)
        }
    }
}
