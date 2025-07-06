//
//  SettingsViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/6/25.
//

import UIKit
import SwiftUI

class SettingsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var moreButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), primaryAction: nil)
        button.tintColor = .white
        return button
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
                    image: UIImage(systemName: "person.fill")!,
                    text: "My Profile",
                    secondary: "",
                    backgroundColor: .cellBackground
                ),
                Model(
                    image: UIImage(systemName: "figure")!,
                    text: "Weight",
                    secondary: "",
                    backgroundColor: .cellBackground
                ),
                Model(
                    image: UIImage(systemName: "fork.knife")!,
                    text: "Meal Types",
                    secondary: "",
                    backgroundColor: .cellBackground
                ),
                Model(
                    image: UIImage(systemName: "moon.fill")!,
                    text: "Theme",
                    secondary: "",
                    backgroundColor: .cellBackground
                )
            ]
        ),
        Section(
            title: "",
            data: [
                Model(
                    image: UIImage(systemName: "moon.fill")!,
                    text: "Theme",
                    secondary: "",
                    backgroundColor: .cellBackground
                ),
            ]
        ),
        Section(
            title: "",
            data: [
                Model(
                    image: UIImage(systemName: "envelope.fill")!,
                    text: "Contact Us",
                    secondary: "",
                    backgroundColor: .cellBackground
                ),
                Model(
                    image: UIImage(systemName: "ant.fill")!,
                    text: "Bug Report",
                    secondary: "",
                    backgroundColor: .cellBackground
                )
            ]
        ),
        Section(
            title: "",
            data: [
                Model(
                    image: UIImage(systemName: "shield.fill")!,
                    text: "Privacy Policy",
                    secondary: "",
                    backgroundColor: .cellBackground
                )
            ]
        )
    ]
    
    let userProfile: UserProfile
    let foodService = FoodService()
    
    private let email = "timmysappstuff@gmail.com"
    
    init(userProfile: UserProfile) {
        self.userProfile = userProfile
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = .background
        navigationItem.title = "Profile"
        navigationController?.navigationBar.prefersLargeTitles = false
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
        
        navigationItem.rightBarButtonItem = moreButton
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
        if indexPath == IndexPath(row: 0, section: 0)  {
            let profileViewController = ProfileViewController(userProfile: userProfile)
            navigationController?.pushViewController(profileViewController, animated: true)
        }

        if indexPath == IndexPath(row: 1, section: 0) {
            let context = CoreDataStack.shared.persistentContainer.viewContext
            let weightProgressView = WeightProgressView()
            let hostingController = UIHostingController(rootView: weightProgressView
                .environment(\.managedObjectContext, context))
            navigationController?.pushViewController(hostingController, animated: true)
        }
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
