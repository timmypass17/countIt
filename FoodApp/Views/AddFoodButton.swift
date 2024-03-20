//
//  AddFoodButton.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/17/24.
//

import UIKit

class AddFoodButton: UIButton {
    
    var section: Int?
    
    init() {
        super.init(frame: .zero)
        configuration = .tinted()
        setImage(UIImage(systemName: "plus"), for: .normal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
