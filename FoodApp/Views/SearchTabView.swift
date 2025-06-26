//
//  SearchTabView.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 6/16/25.
//

import UIKit

protocol SearchTabViewDelegate: AnyObject {
    func searchTabView(_ sender: SearchTabView, didSelectTab tab: SearchTabView.TabItem)
}

class SearchTabView: UIView {
    
    enum TabItem: Int, CaseIterable {
        case all, myRecipes, myFoods
    }

    private let underlineView = UIView()
    private var selectedButton: UIButton?
    
    let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 16
//        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var buttons: [UIButton] = []

    private var visibleTabs: [TabItem]

    weak var delegate: SearchTabViewDelegate?
    
    init(visibleTabs: [TabItem] = TabItem.allCases) {
        self.visibleTabs = visibleTabs
        super.init(frame: .zero)
        setup()
    }
    
    private func setup() {
        backgroundColor = UIColor(hex: "#1c1c1e")

        addSubview(container)
        addSubview(underlineView)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])

        underlineView.backgroundColor = .white
        underlineView.layer.cornerRadius = 1
        underlineView.clipsToBounds = true

        for tab in visibleTabs {
            let button = makeButton(for: tab)
            button.tag = tab.rawValue
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            container.addArrangedSubview(button)
            buttons.append(button)

            // Default selected
            if tab == .all {
                selectedButton = button
            }
        }

        container.addArrangedSubview(UIView()) // Spacer

        DispatchQueue.main.async {
            guard let selectedButton = self.selectedButton else { return }
            let buttonFrame = selectedButton.convert(selectedButton.bounds, to: self)
            // Initalize with no animaton
            self.underlineView.frame = CGRect(
                x: buttonFrame.origin.x,
                y: buttonFrame.maxY - 2,
                width: buttonFrame.width,
                height: 2
            )
        }

        updateButtonColors()
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        backgroundColor = UIColor(hex: "#1c1c1e")
//
//        allButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        recipesButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//        foodsButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
//
//        container.addArrangedSubview(allButton)
//        container.addArrangedSubview(recipesButton)
//        container.addArrangedSubview(foodsButton)
//        container.addArrangedSubview(UIView())
//
//        addSubview(container)
//        addSubview(underlineView)
//
//        underlineView.backgroundColor = .white
//        underlineView.layer.cornerRadius = 1
//        underlineView.clipsToBounds = true
//
//        NSLayoutConstraint.activate([
//            container.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
//            container.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
//            container.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
//            container.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
//        ])
//
//        // Set default selected button after layout
//        selectedButton = allButton
//        // you’re delaying the execution of that code block until the next run loop cycle, after all current layout and constraint updates are finished.
//        DispatchQueue.main.async {
//            guard let selectedButton = self.selectedButton else { return }
//            let buttonFrame = selectedButton.convert(selectedButton.bounds, to: self)
//            // Initalize with no animaton
//            self.underlineView.frame = CGRect(
//                x: buttonFrame.origin.x,
//                y: buttonFrame.maxY - 2,
//                width: buttonFrame.width,
//                height: 2
//            )
//        }
//        updateButtonColors()
//    }
    
    private func makeButton(for tab: TabItem) -> UIButton {
        let button = UIButton()
        switch tab {
        case .all:
            button.setTitle("All", for: .normal)
        case .myRecipes:
            button.setTitle("My Recipes", for: .normal)
        case .myFoods:
            button.setTitle("My Foods", for: .normal)
        }
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        return button
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped(_ sender: UIButton) {
        selectedButton = sender
//        let buttons = [allButton, recipesButton, foodsButton]
        if let index = buttons.firstIndex(where: { $0 == selectedButton }) {
            let selectedTab = visibleTabs[index]
            delegate?.searchTabView(self, didSelectTab: selectedTab)
        }
        
        updateUI()
    }
    
    func updateUI() {
        updateButtonColors()
        updateUnderline()
    }

    private func updateButtonColors() {
//        let buttons = [allButton, recipesButton, foodsButton]
        for button in buttons {
            let isSelected = (button == selectedButton)
            button.setTitleColor(isSelected ? .white : .secondaryLabel, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(
                ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize,
                weight: isSelected ? .semibold : .regular
            )
        }
    }

    private func updateUnderline() {
        guard let selectedButton = selectedButton else { return }
        let buttonFrame = selectedButton.convert(selectedButton.bounds, to: self)
        UIView.animate(withDuration: 0.25) {
            self.underlineView.frame = CGRect(
                x: buttonFrame.origin.x,
                y: buttonFrame.maxY - 2,
                width: buttonFrame.width,
                height: 2
            )
        }
    }
    
}
