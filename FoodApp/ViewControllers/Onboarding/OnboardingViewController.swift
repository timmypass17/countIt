//
//  OnboardingViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/6/25.
//

import UIKit

extension Notification.Name {
    static let userInfoUpdated = Notification.Name("userInfoUpdated")
    static let mealPlanUpdated = Notification.Name("mealPlanUpdated")
    static let onboardingBackButton = Notification.Name("onboardingBack")
    static let reloadDiary = Notification.Name("reloadDiary")
    static let themeUpdated = Notification.Name("themeUpdated")
}

class OnboardingViewController: UIViewController {
    
    let pageViewController: OnboardingPageViewController
    
    init() {
        self.pageViewController = OnboardingPageViewController()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Settings.shared.currentTheme.background.uiColor
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pageViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        pageViewController.didMove(toParent: self)
    }
}
