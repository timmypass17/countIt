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
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        
//        let foodService = FoodService()
//        let dashboardViewController = DashboardViewController()
//        let diaryViewController = DiaryViewController(foodService: foodService)
//        let entryViewController = EntryViewController()
//        let progressViewController = ProgressViewController()
//        let settingsViewController = SettingsViewController()
//
//        let tabBarController = UITabBarController()
//        dashboardViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
//        diaryViewController.tabBarItem = UITabBarItem(title: "Diary", image: UIImage(systemName: "fork.knife"), tag: 0)
//        entryViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus.circle.fill"), tag: 0)
//        progressViewController.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(systemName: "chart.bar.fill"), tag: 0)
//        settingsViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 0)
//
//        tabBarController.viewControllers = [dashboardViewController, diaryViewController, entryViewController, progressViewController, settingsViewController]
//            .map { UINavigationController(rootViewController: $0) }
//        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
//        window?.windowScene = windowScene
//        window?.rootViewController = tabBarController
////        window?.rootViewController = OnboardingViewController()
////        window?.rootViewController = LoginViewController()
//        window?.makeKeyAndVisible()
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let foodService = FoodService()
        window = UIWindow(windowScene: windowScene)

        let appleIDProvider = ASAuthorizationAppleIDProvider()
        guard let userId = KeychainItem.currentUserIdentifier else {
            self.showSignInWithApple()
            return
        }
        
        appleIDProvider.getCredentialState(forUserID: userId) { (credentialState, error) in
            DispatchQueue.main.async {
                switch credentialState {
                case .authorized:
                    if let userProfile = foodService.getUserProfile(id: userId) {
                        // Show main tab bar controller
                        print("timmy has signed in and created account")
                        self.showMainApp(userProfile: userProfile)
                    } else {
                        print("timmy has signed in but has not set up profile")
                        // User may not have finished setting up profile
                        self.showOnboarding(userId: userId)
                    }
                case .revoked, .notFound:
                    print("timmy has not signed in")
                    self.showSignInWithApple()
                default:
                    break
                }
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

        
        self.window?.rootViewController = tabBarController
        self.window?.makeKeyAndVisible()
    }
    
    func showSignInWithApple() {
        self.window?.rootViewController = UIViewController()
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController?.showLoginViewController()
    }
    
    func showOnboarding(userId: String) {
        window?.rootViewController = OnboardingViewController(userId: userId)
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
