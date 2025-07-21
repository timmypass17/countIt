//
//  SearchTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/21/24.
//

import UIKit

protocol HistoryTableViewCellDelegate: AnyObject {
    func historyTableViewCell(_ cell: HistoryTableViewCell, didTapAddButton: Bool)
}

class HistoryTableViewCell: ResultTableViewCell {
    
    class override var reuseIdentifier: String {
        return "HistoryTableViewCell"
    }
    
    func update(history: History) {
        let foodEntry = history.foodEntry
        titleLabel.text = foodEntry?.foodInfo?.name
        descriptionLabel.text = foodEntry?.description()
        
        let sealColor: UIColor
        if foodEntry?.isRecipe == true {
            sealColor = .systemOrange
        } else if foodEntry?.isCustom == true {
            sealColor = .systemGreen
        } else {
            sealColor = .systemBlue
        }
        
        let image = UIImage(
            systemName: "checkmark.seal.fill",
            withConfiguration: UIImage.SymbolConfiguration(paletteColors: [.white, sealColor])
        )
        checkmarkImageView.image = image
        
        backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor
        titleLabel.textColor = Settings.shared.currentTheme.label.uiColor
        descriptionLabel.textColor = Settings.shared.currentTheme.secondary.uiColor
        plusButton.tintColor = Settings.shared.currentTheme.secondary.uiColor
    }
}
