//
//  AddFoodTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//

import UIKit

protocol AddFoodTableViewCellDelegate: AnyObject {
    func didTapAddButton(_ sender: UITableViewCell)
}

class AddFoodTableViewCell: UITableViewCell {
    static let reuseIdentifier = "AddFoodCell"
    
    private let addButton: UIButton  = {
        let button = UIButton(configuration: .tinted())
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    weak var delegate: AddFoodTableViewCellDelegate?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let addAction = UIAction { [self] _ in
            delegate?.didTapAddButton(self)
        }
        addButton.addAction(addAction, for: .touchUpInside)
        contentView.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(title: String) {
        addButton.setTitle(title, for: .normal)
    }
    
    @objc func didTapButton() {
        delegate?.didTapAddButton(self)
    }
}
