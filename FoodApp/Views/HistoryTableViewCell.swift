//
//  SearchTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/21/24.
//

import UIKit

protocol HistoryTableViewCellDelegate: AnyObject {
    func historyTableViewCell(_ cell: HistoryTableViewCell, didSelectDeleteButton: Bool)
}

class HistoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "HistoryCell"

    weak var delegate: HistoryTableViewCellDelegate?

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
    
    let titleContainer: UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .horizontal
        return hstack
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        deleteButton.addAction(deleteButtonTapped(), for: .touchUpInside)
        
        titleContainer.addArrangedSubview(titleLabel)
        titleContainer.addArrangedSubview(checkmarkImageView)
        titleContainer.addArrangedSubview(UIView())
        titleContainer.setCustomSpacing(8, after: titleLabel)
        
        labelContainer.addArrangedSubview(titleContainer)
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
    
    func update(history: History) {
        let foodEntry = history.foodEntry
        titleLabel.text = foodEntry?.foodInfo?.name
        descriptionLabel.text = foodEntry?.description()
//        let totalGramWeight = (foodEntry?.gramWeight ?? 0) * Double(foodEntry?.quantity ?? 0)
//    
//        if foodEntry?.gramWeight == nil {
////            foodEntry
////            descriptionLabel.text =
//        }
//        
//        if let modifer = foodEntry?.modifier {
//            descriptionLabel.text = "\(foodEntry?.quantity ?? 0) \(modifer) (\(totalGramWeight.trimmed) g), \(foodEntry?.foodInfo?.brandName_ ?? "NA")"
//        } else {
//            descriptionLabel.text = "\(totalGramWeight.trimmed) g, \(foodEntry?.foodInfo?.brandName_ ?? "NA")"
//        }
        
        if foodEntry?.isCustom == true {
            checkmarkImageView.tintColor = .systemGreen
        } else {
            checkmarkImageView.tintColor = .systemBlue
        }
    }
    
    func deleteButtonTapped() -> UIAction {
        return UIAction { [self] _ in
            delegate?.historyTableViewCell(self, didSelectDeleteButton: true)
//            CoreDataStack.shared.deleteHistory(cdFood)
//            delegate?.historyTableViewCell(self, didDeleteFood: cdFood)
        }
    }
}
