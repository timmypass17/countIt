//
//  AddFoodTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//

import UIKit

class AddFoodButton: UIView {
    var section: Int?

    let addButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.title = "Add Food"
        config.image = UIImage(systemName: "plus")
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(addButton)
//        backgroundColor = .gray
        
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: self.topAnchor),
            addButton.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            addButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            addButton.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
