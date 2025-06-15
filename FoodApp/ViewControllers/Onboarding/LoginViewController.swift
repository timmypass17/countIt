//
//  LoginViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/12/25.
//

import UIKit
import AuthenticationServices

class LoginViewController: UIViewController {
    
    lazy var signWithAppleButton: ASAuthorizationAppleIDButton = {
        let appleButton = ASAuthorizationAppleIDButton()
        appleButton.addAction(didTapSignInWithApple(), for: .touchUpInside)
        appleButton.translatesAutoresizingMaskIntoConstraints = false
        return appleButton
    }()
    
    let foodService = FoodService()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(signWithAppleButton)
        NSLayoutConstraint.activate([
            signWithAppleButton.topAnchor.constraint(equalTo: view.topAnchor),
            signWithAppleButton.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            signWithAppleButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            signWithAppleButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func didTapSignInWithApple() -> UIAction {
        return UIAction { _ in
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = self
            authorizationController.performRequests()
        }
    }

}

extension LoginViewController: ASAuthorizationControllerDelegate {
    /// - Tag: did_complete_authorization
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            
            // Create an account in your system.
            // If the user revokes your app’s access in their Apple ID settings and then signs in again, you’ll get a new userIdentifier. So save in keychain (used to store small sensitive data, persists even if app is unistalled)
            let userIdentifier = appleIDCredential.user // same even if user signs out or reinstalls app, changes when user selects “Stop Using Apple ID” in settings
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            print("timmy complete apple id credential")
            print(userIdentifier)
            print(fullName)
            print(email)
            // For the purpose of this demo app, store the `userIdentifier` in the keychain.
            self.saveUserInKeychain(userIdentifier)
            
            // Fetch user
            // 1. User exists, show tab
            if let userProfile = foodService.getUserProfile() {
                print("timmy user exists, show main app")
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = createTabBarController(userProfile: userProfile)
                    window.makeKeyAndVisible()
                }
                dismiss(animated: true)
            } else {
                // 2. User does not exist, show onboarding
                print("timmy user does not exist, show onboarding")
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                   let window = windowScene.windows.first {
                    window.rootViewController = OnboardingViewController()
                    window.makeKeyAndVisible()
                }
                dismiss(animated: true)
            }
        default:
            break
        }
    }
    
    func createTabBarController(userProfile: UserProfile) -> UITabBarController {
        let foodService = FoodService()
        let dashboardViewController = DashboardViewController()
        let diaryViewController = DiaryViewController(userProfile: userProfile, foodService: foodService)
        let entryViewController = EntryViewController()
        let progressViewController = ProgressViewController()
        let settingsViewController = SettingsViewController(userProfile: userProfile)

        let tabBarController = UITabBarController()
        dashboardViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        diaryViewController.tabBarItem = UITabBarItem(title: "Diary", image: UIImage(systemName: "fork.knife"), tag: 1)
        entryViewController.tabBarItem = UITabBarItem(title: "", image: UIImage(systemName: "plus.circle.fill"), tag: 2)
        progressViewController.tabBarItem = UITabBarItem(title: "Progress", image: UIImage(systemName: "chart.bar.fill"), tag: 3)
        settingsViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 4)

        tabBarController.viewControllers = [dashboardViewController, diaryViewController, entryViewController, progressViewController, settingsViewController]
            .map { UINavigationController(rootViewController: $0) }

        return tabBarController
    }
    
    private func saveUserInKeychain(_ userIdentifier: String) {
        do {
            try KeychainItem(service: "com.example.apple-samplecode.juice", account: "userIdentifier").saveItem(userIdentifier)
        } catch {
            print("Unable to save userIdentifier to keychain.")
        }
    }
    
//    private func showResultViewController(userIdentifier: String, fullName: PersonNameComponents?, email: String?) {
//        guard let viewController = self.presentingViewController as? ResultViewController
//            else { return }
//        
//        DispatchQueue.main.async {
//            viewController.userIdentifierLabel.text = userIdentifier
//            if let givenName = fullName?.givenName {
//                viewController.givenNameLabel.text = givenName
//            }
//            if let familyName = fullName?.familyName {
//                viewController.familyNameLabel.text = familyName
//            }
//            if let email = email {
//                viewController.emailLabel.text = email
//            }
//            self.dismiss(animated: true, completion: nil)
//        }
//    }
//    
    private func showPasswordCredentialAlert(username: String, password: String) {
        let message = "The app has received your selected credential from the keychain. \n\n Username: \(username)\n Password: \(password)"
        let alertController = UIAlertController(title: "Keychain Credential Received",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// - Tag: did_complete_error
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
    }

}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}
