//
//  OnboardingPageViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/10/25.
//

import UIKit
import CoreData

class OnboardingPageViewController: UIPageViewController {

    var pages: [UIViewController] = []
    
    lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = .white
        pageControl.pageIndicatorTintColor =  .systemGray2
        pageControl.currentPage = initialPage
        pageControl.numberOfPages = pages.count
        pageControl.isUserInteractionEnabled = false
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    lazy var continueButton: UIButton = {
        var configuration = UIButton.Configuration.borderedProminent()
//        configuration.baseForegroundColor = UIColor.systemPink
        configuration.buttonSize = .large
        configuration.title = "Continue"

        let button = UIButton(configuration: configuration, primaryAction: nil) // 3
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(didTapContinueButton(), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let initialPage = 0
    var userProfile: UserProfile
    
    lazy var onboardingGoalViewController: OnboardingGoalViewController = {
        return OnboardingGoalViewController(userProfile: userProfile)
    }()
    
    lazy var onboardingUserViewController: OnboardingUserViewController = {
        return OnboardingUserViewController(userProfile: userProfile)
    }()
    
    lazy var onboardingCalculationViewController: OnboardingCalculationViewController = {
        return OnboardingCalculationViewController(userProfile: userProfile)
    }()
    
    let foodService = FoodService()
    
    init(userProfile: UserProfile) {
        self.userProfile = userProfile
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        pages = [onboardingGoalViewController, onboardingUserViewController, onboardingCalculationViewController].map { UINavigationController(rootViewController: $0) }
        
        view.addSubview(pageControl)
        view.addSubview(continueButton)
        
        NSLayoutConstraint.activate([
            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
            pageControl.heightAnchor.constraint(equalToConstant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            continueButton.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            continueButton.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            continueButton.bottomAnchor.constraint(equalTo: pageControl.topAnchor, constant: -24)
        ])
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserInfoUpdated), name: .userInfoUpdated, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleOnboardingBackButtonTapped), name: .onboardingBackButton, object: nil)
    }
    
    func didTapContinueButton() -> UIAction {
        return UIAction { _ in
            if self.pageControl.currentPage < self.pages.count - 1{
                self.moveNext()
            } else {
                print("timmy profile: \(self.userProfile)")
                self.foodService.createUserProfile(self.userProfile)
                self.showMainApp(userProfile: self.userProfile)
            }

        }
    }
    
    func showMainApp(userProfile: UserProfile) {
        let foodService = FoodService()
        let dashboardViewController = DashboardViewController()
        let diaryViewController = DiaryViewController(userProfile: userProfile, foodService: foodService)
        let entryViewController = EntryViewController()
        let progressViewController = ProgressViewController()
        let settingsViewController = SettingsViewController()

        let tabBarController = UITabBarController()
        dashboardViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        diaryViewController.tabBarItem = UITabBarItem(title: "Diary", image: UIImage(systemName: "fork.knife"), tag: 1)
        entryViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus.circle.fill"), tag: 2)
        progressViewController.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(systemName: "chart.bar.fill"), tag: 3)
        settingsViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 4)

        tabBarController.viewControllers = [dashboardViewController, diaryViewController, entryViewController, progressViewController, settingsViewController]
            .map { UINavigationController(rootViewController: $0) }

        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
    
    func moveNext() {
        continueButton.isEnabled = false

        let nextPage = pageControl.currentPage + 1
        guard nextPage < pages.count else { return }

        pageControl.currentPage = nextPage

        if nextPage == 2 {
            userProfile.recalculateDailyCalories()
            
            if userProfile.carbsGrams == nil &&
                userProfile.proteinGrams == nil &&
                userProfile.fatsGrams == nil {
                userProfile.recalculateMacroSplitGrams()
            }
            onboardingCalculationViewController.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }

        setViewControllers([pages[nextPage]], direction: .forward, animated: true) { _ in
            self.updateContinueButton()
        }
    }
    
    func movePrevious() {
        self.pageControl.currentPage -= 1
        self.setViewControllers([self.pages[self.pageControl.currentPage]], direction: .reverse, animated: true) { _ in
            self.updateContinueButton()
        }
    }
    
    @objc func handleUserInfoUpdated() {
        updateContinueButton()
    }
    
    @objc func handleOnboardingBackButtonTapped() {
        movePrevious()
    }
    
    func updateContinueButton() {
        let valid: Bool
        let title: String

        switch pageControl.currentPage {
        case 0:
            valid = userProfile.currentWeightKg != nil && userProfile.goalWeightKg != nil
            title = "Continue"
        case 1:
            valid = userProfile.sex_ != nil && userProfile.heightCm != nil
            title = "Continue"
        case 2:
            valid = userProfile.currentWeightKg != nil &&
                    userProfile.goalWeightKg != nil &&
                    userProfile.sex_ != nil &&
                    userProfile.heightCm != nil &&
                    userProfile.dailyCalories != nil &&
                    userProfile.carbsGrams != nil &&
                    userProfile.proteinGrams != nil &&
                    userProfile.fatsGrams != nil
            title = "Finish"
        default:
            valid = false
            title = "Continue"
        }

        continueButton.isEnabled = valid
        continueButton.setTitle(title, for: .normal)
    }
}
