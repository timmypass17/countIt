//
//  SceneDelegate.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 3/1/24.
//

import UIKit
import WidgetKit
import AuthenticationServices

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let foodService = FoodService()
        window = UIWindow(windowScene: windowScene)

        if let userProfile = foodService.getUserProfile() {
            // Show main tab bar controller
            print("timmy has signed in and created account")
            self.showMainApp(userProfile: userProfile)
        } else {
            print("timmy has signed in but has not set up profile")
            // User may not have finished setting up profile
            self.showOnboarding()
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
    
    func showSignInWithApple() {
        self.window?.rootViewController = UIViewController()
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController?.showLoginViewController()
    }
    
    func showOnboarding() {
        window?.rootViewController = OnboardingViewController()
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        
        // TODO: Uncomment this
//        CoreDataStack.shared.saveContext()
//        WidgetCenter.shared.reloadAllTimelines()
    }


}
