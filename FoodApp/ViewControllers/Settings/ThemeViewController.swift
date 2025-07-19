//
//  ThemeViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/12/25.
//

import UIKit
import WidgetKit

protocol ThemeViewControllerDelegate: AnyObject {
    func themeViewController(_ controller: ThemeViewController, didSelectTheme theme: UIUserInterfaceStyle)
}

class ThemeViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = Settings.shared.currentTheme.background.uiColor
        return tableView
    }()
    
    weak var delegate: ThemeViewControllerDelegate?
    
    let themes: [AppTheme] = [LightTheme(), DarkTheme()]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "ThemeCell")
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = "Appearance"
        navigationItem.largeTitleDisplayMode = .never
        
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func updateUI() {
        tableView.backgroundColor = Settings.shared.currentTheme.background.uiColor
        tableView.reloadData()
    }

}

extension ThemeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ThemeCell", for: indexPath)

        let theme = themes[indexPath.row]

        var content = cell.defaultContentConfiguration()
        content.text = theme.name
        content.textProperties.color = Settings.shared.currentTheme.label.uiColor
        cell.contentConfiguration = content

        cell.accessoryType = theme.name == Settings.shared.currentTheme.name
            ? .checkmark : .none

        cell.backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor

        return cell
    }

    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Some appearance changes may require restarting the app to fully apply."
    }
}

extension ThemeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let theme = themes[indexPath.row]
        Settings.shared.currentTheme = theme
        NotificationCenter.default.post(name: .themeUpdated, object: nil)
        WidgetCenter.shared.reloadTimelines(ofKind: MacroWidget.kind)
//        delegate?.themeTableViewController(self, didSelectTheme: theme)
        updateUI()
    }
}
