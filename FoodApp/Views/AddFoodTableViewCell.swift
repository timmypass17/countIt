//
//  AddFoodTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/27/24.
//

import UIKit

class AddFoodTableViewCell: UITableViewCell {
    static let reuseIdentifier = "AddFoodCell"
    
    var plusImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "plus"))
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFit
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Food"
//        label.textColor = .systemBlue
        label.textColor = .secondaryLabel
        return label
    }()
    
    var container: UIStackView = {
        let hstack = UIStackView()
        hstack.axis = .horizontal
        hstack.spacing = 4
        hstack.translatesAutoresizingMaskIntoConstraints = false
        return hstack
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        container.addArrangedSubview(plusImageView)
        container.addArrangedSubview(titleLabel)
        
        self.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
