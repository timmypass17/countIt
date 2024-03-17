//
//  AddFoodButton.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//

import UIKit

class AddFoodButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configuration = .tinted()
        setImage(UIImage(systemName: "plus"), for: .normal)
        addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(title: String) {
        setTitle(title, for: .normal)
    }
    
    @objc func didTapButton() {
//        delegate?.didTapAddButton(self)
    }
}
