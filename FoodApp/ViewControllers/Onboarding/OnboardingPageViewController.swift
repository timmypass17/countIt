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
    let userProfile: UserProfile
    var startingWeightKg: Double? = nil
    
    var onboardingGoalViewController: OnboardingGoalViewController?
    var onboardingUserViewController: OnboardingUserViewController?
    var onboardingCalculationViewController: OnboardingCalculationViewController?
    
    let foodService = FoodService()
    
    init() {
        userProfile = UserProfile(context: CoreDataStack.shared.context)
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        onboardingGoalViewController = OnboardingGoalViewController(userProfile: userProfile)
        onboardingGoalViewController?.delegate = self
        onboardingUserViewController = OnboardingUserViewController(userProfile: userProfile)
        onboardingCalculationViewController = OnboardingCalculationViewController(userProfile: userProfile)
        pages = [onboardingGoalViewController, onboardingUserViewController, onboardingCalculationViewController]
            .compactMap { $0}
            .map { UINavigationController(rootViewController: $0) }
        
        
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
                do {
                    try self.foodService.createUserProfile(self.userProfile)
                    try self.foodService.createUserWeight(weightInKg: self.startingWeightKg ?? 0, date: .now)
                    self.showMainApp(userProfile: self.userProfile)
                } catch {
                    print("Failed to create User profile: \(error)")
                }
            }
        }
    }
    
    func showMainApp(userProfile: UserProfile) {
        let foodService = FoodService()
        let diaryViewController = DiaryViewController(userProfile: userProfile, foodService: foodService)
        let searchViewController = SearchFoodTableViewController(foodService: foodService, userProfile: userProfile)
        let progressViewController = ProgressViewController(foodService: foodService, userProfile: userProfile)
        let settingsViewController = SettingsViewController(userProfile: userProfile)

        diaryViewController.delegate = searchViewController
        searchViewController.resultDelegate = diaryViewController
        searchViewController.addFoodDelegate = diaryViewController
        
        diaryViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "house"), tag: 0)

        searchViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "magnifyingglass"), tag: 1)

        progressViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "chart.bar.fill"), tag: 2)

        settingsViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.fill"), tag: 3)

        // Set view controllers
        let tabBarController = UITabBarController()
        tabBarController.viewControllers = [
            diaryViewController,
            searchViewController,
            progressViewController,
            settingsViewController
        ].map { UINavigationController(rootViewController: $0) }

        // Customize tab bar appearance
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex: "#191919")

        // Set selected and unselected icon colors
        appearance.stackedLayoutAppearance.selected.iconColor = .white
        appearance.stackedLayoutAppearance.normal.iconColor = .secondaryLabel

        tabBarController.tabBar.standardAppearance = appearance
        if #available(iOS 15.0, *) {
            tabBarController.tabBar.scrollEdgeAppearance = appearance
        }

        // Also update tint color to match selected icon
        tabBarController.tabBar.tintColor = .white
        
        // Set as root
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
    }
    
//    func showMainApp(userProfile: UserProfile) {
//        let foodService = FoodService()
//        let diaryViewController = DiaryViewController(userProfile: userProfile, foodService: foodService)
//        
//        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//           let window = windowScene.windows.first {
//            window.rootViewController = UINavigationController(rootViewController: diaryViewController)
//            window.makeKeyAndVisible()
//        }
//    }
    
    func moveNext() {
        continueButton.isEnabled = false

        let nextPage = pageControl.currentPage + 1
        guard nextPage < pages.count else { return }

        pageControl.currentPage = nextPage

        if nextPage == 2 {
            guard let startingWeightKg else { return }
            let bmr = userProfile.bmr(currentWeightKg: startingWeightKg)
            let tdee = userProfile.tdee(bmr: bmr)
            userProfile.recalculateDailyCalories(tdee: tdee)
            
            if userProfile.carbsGrams == nil &&
                userProfile.proteinGrams == nil &&
                userProfile.fatsGrams == nil {
                userProfile.recalculateMacroSplitGrams()
            }
            onboardingCalculationViewController?.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
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
            valid = startingWeightKg != nil && userProfile.goalWeightKg != nil
            title = "Continue"
        case 1:
            valid = userProfile.sex_ != nil && userProfile.heightCm != nil
            title = "Continue"
        case 2:
            valid = startingWeightKg != nil &&
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

extension OnboardingPageViewController: OnboardingGoalViewControllerDelegate {
    func onboardingGoalViewController(_ viewController: OnboardingGoalViewController, didUpdateCurrentWeightKg weightKg: Double?) {
        self.startingWeightKg = weightKg
    }
}
