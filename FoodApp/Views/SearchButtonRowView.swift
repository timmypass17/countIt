//
//  SearchButtonRowView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/16/25.
//

import UIKit

protocol SearchButtonRowViewDelegate: AnyObject {
    func searchButtonRowView(_ sender: SearchButtonRowView, didTapButton type: SearchButtonRowView.SearchButtonType)
}

class SearchButtonRowView: UIView {
    
    enum SearchButtonType: Int, CaseIterable {
        case barcode, quickAdd, addRecipe, addFood
    }

    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var searchButtonsView: [SearchButtonView] = []
    
    weak var delegate: SearchButtonRowViewDelegate?
    private var visibleButtonTypes: [SearchButtonType]

    init(visibleButtonTypes: [SearchButtonType] = SearchButtonType.allCases) {
        self.visibleButtonTypes = visibleButtonTypes
        super.init(frame: .zero)
        setup()
    }
    
    func setup() {
        for buttonType in visibleButtonTypes {
            let button = makeButton(for: buttonType)
            button.addTarget(self, action: #selector(didTapSearchButton), for: .touchUpInside)
            searchButtonsView.append(button)
            container.addArrangedSubview(button)
        }
        
        addSubview(container)
        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
        
        updateUI()
    }
    
    private func makeButton(for buttonType: SearchButtonType) -> SearchButtonView {
        switch buttonType {
        case .barcode:
            return SearchButtonView(title: "Barcode", image: UIImage(systemName: "barcode.viewfinder"))
        case .quickAdd:
            return SearchButtonView(title: "Quick Add", image: UIImage(systemName: "flame"))
        case .addRecipe:
            return SearchButtonView(title: "Add Recipe", image: UIImage(systemName: "plus"))
        case .addFood:
            return SearchButtonView(title: "Add Food", image: UIImage(systemName: "plus"))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func didTapSearchButton(_ sender: SearchButtonView) {
        guard let index = searchButtonsView.firstIndex(where: { $0 == sender }) else { return }
        let type = visibleButtonTypes[index]
        delegate?.searchButtonRowView(self, didTapButton: type)
    }
    
    func updateUI() {
        for button in searchButtonsView {
            button.backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor
        }
    }
}

class SearchButtonView: UIControl {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = Settings.shared.currentTheme.color1.uiColor
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = Settings.shared.currentTheme.color1.uiColor
        label.adjustsFontSizeToFitWidth = true  // shrink text
        label.minimumScaleFactor = 0.7 // down to 70%
        label.lineBreakMode = .byClipping
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()
    
    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    init(title: String, image: UIImage?) {
        super.init(frame: .zero)
        titleLabel.text = title
        imageView.image = image
        
        container.addArrangedSubview(imageView)
        container.addArrangedSubview(titleLabel)
        addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor, constant: 4),
            container.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor, constant: -4),
            container.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
        
        backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor
        layer.cornerRadius = 8
        clipsToBounds = true
        isUserInteractionEnabled = true
        
        imageView.isUserInteractionEnabled = false
        titleLabel.isUserInteractionEnabled = false
        container.isUserInteractionEnabled = false
    }
    
    // Optional: Touch feedback
    override var isHighlighted: Bool {
        didSet {
            alpha = isHighlighted ? 0.5 : 1.0
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
