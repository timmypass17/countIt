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
    
    func update(history: History) {
        let food = history.food
        titleLabel.text = food?.foodInfo?.name
        let totalGramWeight = (food?.gramWeight ?? 0) * Double(food?.quantity ?? 0)
        if let modifer = food?.modifier {
            descriptionLabel.text = "\(food?.quantity ?? 0) \(modifer) (\(totalGramWeight.trimmed) g), \(food?.foodInfo?.brandName_ ?? "NA")"
        } else {
            descriptionLabel.text = "\(totalGramWeight.trimmed) g, \(food?.foodInfo?.brandName_ ?? "NA")"
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
