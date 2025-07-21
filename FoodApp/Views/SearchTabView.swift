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

    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = Settings.shared.currentTheme.label.uiColor
        view.layer.cornerRadius = 1
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private var underlineLeadingConstraint: NSLayoutConstraint?
    private var underlineWidthConstraint: NSLayoutConstraint?
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
        backgroundColor = Settings.shared.currentTheme.background.uiColor

        addSubview(container)
        addSubview(underlineView)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])


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

        updateUI()
    }

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
        if let index = buttons.firstIndex(where: { $0 == selectedButton }) {
            let selectedTab = visibleTabs[index]
            delegate?.searchTabView(self, didSelectTab: selectedTab)
        }
        
        updateUI()
    }
    
    func updateUI() {
        updateButtonColors()
        updateUnderline()
        backgroundColor = Settings.shared.currentTheme.background.uiColor
    }

    private func updateButtonColors() {
        for button in buttons {
            let isSelected = (button == selectedButton)
            button.setTitleColor(isSelected ? Settings.shared.currentTheme.label.uiColor : Settings.shared.currentTheme.secondary.uiColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(
                ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize,
                weight: isSelected ? .semibold : .regular
            )
        }
    }

    private func updateUnderline() {
        guard let selectedButton = selectedButton else { return }

        underlineView.backgroundColor = Settings.shared.currentTheme.label.uiColor

        underlineLeadingConstraint?.isActive = false
        underlineWidthConstraint?.isActive = false

        underlineLeadingConstraint = underlineView.leadingAnchor.constraint(equalTo: selectedButton.leadingAnchor)
        underlineWidthConstraint = underlineView.widthAnchor.constraint(equalTo: selectedButton.widthAnchor)

        NSLayoutConstraint.activate([
            underlineLeadingConstraint!,
            underlineWidthConstraint!,
            underlineView.bottomAnchor.constraint(equalTo: selectedButton.bottomAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 2)
        ])

        UIView.animate(withDuration: 0.25) {
            // forces the view to immediately update its layout, only if needed
            // “If any layout changes (e.g. constraints) are pending, apply them now.”
            // used to make sure constraint changes are reflected immediately, especially inside animations.
            self.layoutIfNeeded()
        }
    }
    
}
