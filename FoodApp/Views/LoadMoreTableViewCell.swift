//
//  LoadMoreTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/3/25.
//

import UIKit

class LoadMoreTableViewCell: UITableViewCell {
    static let reuseIdentifier = "LoadMoreTableViewCell"
    
    let loadMoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Show More"
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(hex: "#252525")
        
        contentView.addSubview(loadMoreLabel)
        NSLayoutConstraint.activate([
            loadMoreLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            loadMoreLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            loadMoreLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            loadMoreLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
