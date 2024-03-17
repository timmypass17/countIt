//
//  AddFoodButton.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//

import UIKit

protocol AddFoodButtonDelegate: AnyObject {
    func addFoodButton(_ sender: AddFoodButton, didTapButton: Bool, forSectionAt section: Int)
}

class AddFoodButton: UIButton {
    
    let section: Int
    weak var delegate: AddFoodButtonDelegate?
    
    init(section: Int) {
        self.section = section
        super.init(frame: .zero)
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
        delegate?.addFoodButton(self, didTapButton: true, forSectionAt: section)
    }
}
