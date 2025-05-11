//
//  OnboardingViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/6/25.
//

import UIKit

extension Notification.Name {
    static let userInfoUpdated = Notification.Name("userInfoUpdated")
    static let onboardingBackButton = Notification.Name("onboardingBack")
}

class OnboardingViewController: UIViewController {
    
    let pageViewController = OnboardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .charcoal
        
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
//        configuration.cornerStyle = .capsule
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
    var userInfo: UserInfo = UserInfo(weightGoal: .loseWeight, currentWeight: nil, goalWeight: nil, weeklyGoal: .lose1_0, unitPreference: UnitPreference(weightUnit: .pounds, heightUnit: .feet), activityLevel: .lightlyActive, heightCm: nil, dateOfBirth: .now, dailyCalories: 2000, macroSplit: MacroSplit(carbs: 40, protein: 40, fats: 20), sex: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
//        dataSource = self
        delegate = self
        
        let onboardingViewController = OnboardingGoalViewController(userInfo: userInfo)
        let onboardingUserViewController = OnboardingUserViewController(userInfo: userInfo)
        let onboardingCalculationViewController = OnboardingCalculationViewController(userInfo: userInfo)

        pages = [onboardingViewController, onboardingUserViewController, onboardingCalculationViewController].map { UINavigationController(rootViewController: $0) }
        
        
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
            self.moveNext()
        }
    }
    
    func moveNext() {
        pageControl.currentPage += 1
        setViewControllers([pages[pageControl.currentPage]], direction: .forward, animated: true) { _ in
            self.updateContinueButton()
        }
        
        if pageControl.currentPage == 2 {
            // Calculate calories
            
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
        if pageControl.currentPage == 0 {
            continueButton.isEnabled = userInfo.currentWeightKg != nil && userInfo.goalWeightKg != nil
            continueButton.setTitle("Continue", for: .normal)
        } else if pageControl.currentPage == 1 {
            continueButton.isEnabled = userInfo.sex != nil && userInfo.heightCm != nil
            continueButton.setTitle("Continue", for: .normal)
        } else if pageControl.currentPage == 2 {
            continueButton.setTitle("Finish", for: .normal)
            print(userInfo)
        }
    }
}


// MARK: - DataSource

//extension OnboardingPageViewController: UIPageViewControllerDataSource {
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        print(#function)
//        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
//        
//        if currentIndex == 0 {
//            return nil               // wrap last
//        } else {
//            return pages[currentIndex - 1]  // go previous
//        }
//    }
//        
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        print(#function)
//        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
//
//        if currentIndex < pages.count - 1 {
//            return pages[currentIndex + 1]  // go next
//        } else {
//            return nil              // wrap first
//        }
//    }
//}

// MARK: - Delegates

extension OnboardingPageViewController: UIPageViewControllerDelegate {
    
//    // How we keep our pageControl in sync with viewControllers
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        print(#function)
//        guard let viewControllers = pageViewController.viewControllers else { return }
//        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
//        
//        pageControl.currentPage = currentIndex
//    }
}

// MARK: - Actions

extension OnboardingPageViewController {

//    @objc func pageControlTapped(_ sender: UIPageControl) {
//        print(#function)
//        setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true, completion: nil)
//        animateControlsIfNeeded()
//    }

//    func didTapSkipButton() -> UIAction {
//        return UIAction { _ in
//            let lastPageIndex = self.pages.count - 1
//            self.pageControl.currentPage = lastPageIndex
//            
//            self.goToSpecificPage(index: lastPageIndex, ofViewControllers: self.pages)
//            self.animateControlsIfNeeded()
//        }
//    }
}

// MARK: - Extensions

extension UIPageViewController {

//    func goToNextPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
//        guard let currentPage = viewControllers?[0] else { return }
//        guard let nextPage = dataSource?.pageViewController(self, viewControllerAfter: currentPage) else { return }
//        
//        setViewControllers([nextPage], direction: .forward, animated: animated, completion: completion)
//    }
//    
//    func goToPreviousPage(animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
//        guard let currentPage = viewControllers?[0] else { return }
//        guard let prevPage = dataSource?.pageViewController(self, viewControllerBefore: currentPage) else { return }
//        
//        setViewControllers([prevPage], direction: .forward, animated: animated, completion: completion)
//    }
//    
//    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
//        setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
//    }
}

//class ViewController: UIPageViewController {
//
//    lazy var pages: [UIViewController] = {
//        return [OnboardingGoalViewController(), ViewController2(), ViewController3()]
//    }()
//    
//    lazy var pageControl: UIPageControl = {
//        let pageControl = UIPageControl()
//        pageControl.addAction(didTapPageControl(), for: .valueChanged)
//        pageControl.currentPageIndicatorTintColor = .blue// .white
//        pageControl.pageIndicatorTintColor =  .red // .systemGray2
//        pageControl.currentPage = initialPage
//        pageControl.numberOfPages = pages.count
//        pageControl.translatesAutoresizingMaskIntoConstraints = false
//        return pageControl
//    }()
//    
//    let initialPage = 0
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        dataSource = self
//        delegate = self
//        view.addSubview(pageControl)
//        
//        NSLayoutConstraint.activate([
//            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
//            pageControl.widthAnchor.constraint(equalTo: view.widthAnchor),
//            pageControl.heightAnchor.constraint(equalToConstant: 20),
//        ])
//        
//        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)
//    }
//}

// MARK: - Actions

//extension ViewController {
//    
//    // How we change page when pageControl tapped.
//    // Note - Can only skip ahead on page at a time.
//    func didTapPageControl() -> UIAction {
//        return UIAction { _ in
//            self.setViewControllers([self.pages[self.pageControl.currentPage]], direction: .forward, animated: true, completion: nil)
//        }
//    }
//}

// MARK: - DataSources

//extension ViewController: UIPageViewControllerDataSource {
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
//        
//        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
//        
//        if currentIndex == 0 {
//            return pages.last               // wrap to last
//        } else {
//            return pages[currentIndex - 1]  // go previous
//        }
//    }
//    
//    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        
//        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
//
//        if currentIndex < pages.count - 1 {
//            return pages[currentIndex + 1]  // go next
//        } else {
//            return pages.first              // wrap to first
//        }
//    }
//}

// MARK: - Delegates
//
//extension ViewController: UIPageViewControllerDelegate {
//    
//    // How we keep our pageControl in sync with viewControllers
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        
//        guard let viewControllers = pageViewController.viewControllers else { return }
//        guard let currentIndex = pages.firstIndex(of: viewControllers[0]) else { return }
//        
//        pageControl.currentPage = currentIndex
//    }
//}

// MARK: - ViewControllers

class ViewController2: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .charcoal
    }
}

class ViewController3: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .charcoal
    }
}

class ViewController4: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .charcoal
    }
}
