//
//  SettingsViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/6/25.
//

import UIKit

class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    struct Section {
        var title: String
        var data: [Model]
    }
    
    struct Model {
        let image: UIImage?
        let text: String
        var secondary: String?
        var backgroundColor: UIColor?
        let isOn: Bool?
        
        init(image: UIImage, text: String, secondary: String? = nil, backgroundColor: UIColor?, isOn: Bool? = nil) {
            self.image = image
            self.text = text
            self.secondary = secondary
            self.backgroundColor = backgroundColor
            self.isOn = isOn
        }
    }
    
    var sections = [
        Section(
            title: "",
            data: [
                Model(
                    image: UIImage(systemName: "book.pages.fill")!,
                    text: "My Meals, Recipes & Foods",
                    secondary: "",
                    backgroundColor: .charcoal
                ),
                Model(
                    image: UIImage(systemName: "chart.bar.fill")!,  // flag
                    text: "Goals",
                    secondary: "",
                    backgroundColor: .charcoal
                ),
                Model(
                    image: UIImage(systemName: "figure")!,
                    text: "Weight",
                    secondary: "",
                    backgroundColor: .charcoal
                ),
                Model(
                    image: UIImage(systemName: "bell.fill")!,
                    text: "Notifications",
                    secondary: "",
                    backgroundColor: .charcoal
                ),
                Model(
                    image: UIImage(systemName: "ruler.fill")!,
                    text: "Units",
                    secondary: "",
                    backgroundColor: .charcoal
                ),
                Model(
                    image: UIImage(systemName: "fork.knife")!,
                    text: "Meal Types",
                    secondary: "",
                    backgroundColor: .charcoal
                ),
                Model(
                    image: UIImage(systemName: "person.fill")!,
                    text: "Personal Info",
                    secondary: "",
                    backgroundColor: .charcoal
                ),
                Model(
                    image: UIImage(systemName: "person.fill")!,
                    text: "Sign Out",
                    secondary: "",
                    backgroundColor: .charcoal
                ),
                Model(
                    image: UIImage(systemName: "person.fill")!,
                    text: "Delete Account",
                    secondary: "",
                    backgroundColor: .charcoal
                )
            ]
        )
    ]

    static let weightIndexPath = IndexPath(row: 0, section: 0)
    static let showTimerIndexPath = IndexPath(row: 1, section: 0)
    static let hapticIndexPath = IndexPath(row: 2, section: 0)

    let foodService = FoodService()
    
    private let email = "timmysappstuff@gmail.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SettingsSelectableTableViewCell.self, forCellReuseIdentifier: SettingsSelectableTableViewCell.reuseIdentifier)
        
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: true)
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsSelectableTableViewCell.reuseIdentifier, for: indexPath) as! SettingsSelectableTableViewCell
        let model = sections[indexPath.section].data[indexPath.row]
        cell.update(with: model)
        return cell

    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == sections[0].data.count - 2 {
            print("sign out")
            foodService.signOut()
            self.showLoginViewController()
        } else if indexPath.row == sections[0].data.count - 1 {
            do {
                try foodService.deleteAccount()
                self.showLoginViewController()
            } catch {
                print("Error deleting account: \(error)")
            }
        }
//        if indexPath == SettingsTableViewController.weightIndexPath {
//            let weightTableViewController = WeightTableViewController(style: .grouped)
//            weightTableViewController.delegate = self
//            navigationController?.pushViewController(weightTableViewController, animated: true)
//        } else if indexPath == SettingsTableViewController.themeIndexpath {
//            let themeTableViewController = ThemeTableViewController(style: .grouped)
//            themeTableViewController.delegate = self
//            navigationController?.pushViewController(themeTableViewController, animated: true)
//        } else if indexPath == SettingsTableViewController.accentColorIndexpath {
//            let accentColorTableViewController = AccentColorTableViewController(style: .grouped)
//            accentColorTableViewController.delegate = self
//            navigationController?.pushViewController(accentColorTableViewController, animated: true)
//        } else if indexPath == SettingsTableViewController.contactIndexPath {
//            guard MFMailComposeViewController.canSendMail() else {
//                showMailErrorAlert()
//                return
//            }
//            
//            let mailComposer = MFMailComposeViewController()
//            mailComposer.mailComposeDelegate = self
//            mailComposer.setToRecipients([email])
//            mailComposer.setSubject("[BuiltDiff] Contact Us")
//            
//            present(mailComposer, animated: true)
//        } else if indexPath == SettingsTableViewController.bugIndexPath {
//            guard MFMailComposeViewController.canSendMail() else {
//                showMailErrorAlert()
//                return
//            }
//            
//            let mailComposer = MFMailComposeViewController()
//            mailComposer.mailComposeDelegate = self
//            
//            mailComposer.setToRecipients([email])
//            mailComposer.setSubject("[BuiltDiff] Bug Report")
//            
//            present(mailComposer, animated: true)
//        } else if indexPath == SettingsTableViewController.privacyIndexPath {
//            let privacyTableViewController = PrivacyTableViewController(style: .insetGrouped)
//            navigationController?.pushViewController(privacyTableViewController, animated: true)
//        }
    }
}

//extension SettingsViewController: WeightTableViewControllerDelegate {
//    func weightTableViewController(_ viewController: WeightTableViewController, didSelectWeightType weightType: WeightType) {
//        let weightIndexPath = SettingsTableViewController.weightIndexPath
//        sections[weightIndexPath.section].data[weightIndexPath.row].secondary = weightType.fullDescription
//        tableView.reloadRows(at: [weightIndexPath], with: .automatic)
//    }
//}
//
//extension SettingsViewController: ThemeTableViewControllerDelegate {
//    func themeTableViewController(_ controller: ThemeTableViewController, didSelectTheme theme: UIUserInterfaceStyle) {
//        let themeIndexPath = SettingsTableViewController.themeIndexpath
//        sections[themeIndexPath.section].data[themeIndexPath.row].secondary = theme.description
//        tableView.reloadRows(at: [themeIndexPath], with: .automatic)
//    }
//}
//
//extension SettingsViewController: AccentColorTableViewControllerDelegate {
//    func accentColorTableViewController(_ controller: AccentColorTableViewController, didSelectAccentColor color: UIColor, colorName: String?) {
//        let colorIndexPath = SettingsTableViewController.accentColorIndexpath
//        for j in 0..<sections[0].data.count {
//            sections[0].data[j].backgroundColor = color
//        }
//        sections[colorIndexPath.section].data[colorIndexPath.row].secondary = colorName ?? "Custom".localized
//        
//        tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
//        tableView.reloadRows(at: [colorIndexPath], with: .automatic)
//    }
//}
//
//extension SettingsViewController: MFMailComposeViewControllerDelegate {
//    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
//        dismiss(animated: true)
//        if let selectedIndexPath = tableView.indexPathForSelectedRow {
//            tableView.deselectRow(at: selectedIndexPath, animated: true)
//        }
//    }
//    
//    func showMailErrorAlert() {
//        let alert = UIAlertController(
//            title: "No Email Account Found".localized,
//            message: "There is no email account associated to this device. If you have any questions, please feel free to reach out to us at %@".localized(email),
//            preferredStyle: .alert)
//        
//        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { _ in }))
//        self.present(alert, animated: true, completion: nil)
//    }
//}
//
//extension SettingsViewController: ToggleableSettingsTableViewCellDelegate {
//    func toggleableSettingsTableViewCell(_ sender: ToggleableSettingsTableViewCell, toggleValueChanged: Bool) {
//        guard let indexPath = tableView.indexPath(for: sender) else { return }
//        if indexPath == SettingsTableViewController.showTimerIndexPath {
//            Settings.shared.showTimer = toggleValueChanged
//        } else if indexPath == SettingsTableViewController.hapticIndexPath {
//            Settings.shared.enableHaptic = toggleValueChanged
//        }
//    }
//}
