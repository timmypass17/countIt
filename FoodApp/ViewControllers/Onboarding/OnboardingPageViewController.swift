//
//  OnboardingPageViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/10/25.
//

import UIKit

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
    var userProfile: UserProfile = UserProfile(weightGoal: .loseWeight, currentWeight: nil, goalWeight: nil, weeklyGoal: .lose1_0, unitPreference: UnitPreference(weightUnit: .pounds, heightUnit: .feet), activityLevel: .lightlyActive, heightCm: nil, dateOfBirth: .now, dailyCalories: 2000, macroSplit: MacroSplit(carbsPercentage: 40, proteinPercentage: 30, fatsPercentage: 30, carbsGrams: nil, proteinGrams: nil, fatsGrams: nil), sex: nil)

    lazy var onboardingGoalViewController: OnboardingGoalViewController = {
        return OnboardingGoalViewController(userProfile: userProfile)
    }()
    
    lazy var onboardingUserViewController: OnboardingUserViewController = {
        return OnboardingUserViewController(userProfile: userProfile)
    }()
    
    lazy var onboardingCalculationViewController: OnboardingCalculationViewController = {
        return OnboardingCalculationViewController(userProfile: userProfile)
    }()
    
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
                print(self.userProfile)
            }

        }
    }
    
    func moveNext() {
        continueButton.isEnabled = false

        let nextPage = pageControl.currentPage + 1
        guard nextPage < pages.count else { return }

        pageControl.currentPage = nextPage

        if nextPage == 2 {
            userProfile.recalculateDailyCalories()
            if userProfile.macroSplit.carbsGrams == nil &&
                userProfile.macroSplit.proteinGrams == nil &&
                userProfile.macroSplit.fatsGrams == nil {
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
            valid = userProfile.sex != nil && userProfile.heightCm != nil
            title = "Continue"
        case 2:
            valid = userProfile.currentWeightKg != nil &&
                    userProfile.goalWeightKg != nil &&
                    userProfile.sex != nil &&
                    userProfile.heightCm != nil &&
                    userProfile.dailyCalories != nil &&
                    userProfile.macroSplit.carbsGrams != nil &&
                    userProfile.macroSplit.proteinGrams != nil &&
                    userProfile.macroSplit.fatsGrams != nil
            title = "Finish"
        default:
            valid = false
            title = "Continue"
        }

        continueButton.isEnabled = valid
        continueButton.setTitle(title, for: .normal)
    }
}
