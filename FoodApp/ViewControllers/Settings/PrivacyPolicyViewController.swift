//
//  PrivacyPolicyViewController.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 7/9/25.
//

import UIKit

class PrivacyPolicyViewController: UITableViewController {

    var privacyText = "All your food and personal data is securely stored locally on your device. This means only you have access—no one else can view or share your information—ensuring complete privacy and confidentiality."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Settings.shared.currentTheme.background.uiColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "PrivacyCell")
        navigationItem.title = "Privacy Policy"
        navigationItem.largeTitleDisplayMode = .never
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PrivacyCell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = privacyText
        cell.contentConfiguration = config
        cell.backgroundColor = Settings.shared.currentTheme.cellBackground.uiColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Data Privacy"
    }

}
