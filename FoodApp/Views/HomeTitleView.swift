//
//  HomeTitleView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/16/24.
//

import UIKit

class HomeTitleView: UIView {
    
    var dateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Today", for: .normal)
        return button
    }()
    
    var previousButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    var nextButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = .systemGray
        return button
    }()
    
    var container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
//        self.backgroundColor = .gray
        container.addArrangedSubview(previousButton)
        container.addArrangedSubview(dateButton)
        container.addArrangedSubview(nextButton)
        self.addSubview(container)
        
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: self.topAnchor),
            container.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: self.trailingAnchor),

        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
