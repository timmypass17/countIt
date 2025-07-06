//
//  DeleteAccountTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/13/25.
//

import UIKit

class DeleteAccountTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "DeleteAccountTableViewCell"
    
    let deleteLabel: UILabel = {
        let label = UILabel()
        label.text = "Delete Account"
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .cellBackground

        contentView.addSubview(deleteLabel)
        
        NSLayoutConstraint.activate([
            deleteLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            deleteLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            deleteLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            deleteLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
