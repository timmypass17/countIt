//
//  AddFoodTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//

import UIKit

class AddItemView: UIView {
    var section: Int?

    let addButton: UIButton = {
        let button = UIButton(configuration: .tinted())
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(addButton)
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: self.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
