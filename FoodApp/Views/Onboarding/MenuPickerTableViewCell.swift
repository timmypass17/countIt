//
//  WeeklyGoalTableViewCell.swift
//  FoodApp
//
//  Created by Timmy Nguyen on 5/7/25.
//

import UIKit

class MenuPickerTableViewCell<OptionType: Equatable>: UITableViewCell {

    static var reuseIdentifier: String { String(describing: Self.self) }

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    }()

    private let menuButton: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "Title"
        config.baseForegroundColor = .secondaryLabel

        let button = UIButton(configuration: config)
        button.showsMenuAsPrimaryAction = true
        button.changesSelectionAsPrimaryAction = true
        button.contentHorizontalAlignment = .trailing
        return button
    }()

    private let container: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private var onSelect: ((OptionType) -> Void)?
    private var selectedOption: OptionType?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .cellBackground

        container.addArrangedSubview(titleLabel)
        container.addArrangedSubview(menuButton)
        contentView.addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(
        title: String,
        options: [OptionType],
        selected: OptionType,
        titleProvider: @escaping (OptionType) -> String,
        descriptionProvider: @escaping (OptionType) -> String,
        onSelect: @escaping (OptionType) -> Void
    ) {
        self.onSelect = onSelect
        self.selectedOption = selected
        titleLabel.text = title
        menuButton.setTitle(titleProvider(selected), for: .normal)
        print(titleProvider(selected))
        menuButton.menu = UIMenu(title: "", children: options.map { option in
            UIAction(title: titleProvider(option), subtitle: descriptionProvider(option), state: option == selected ? .on : .off) { _ in
                self.selectedOption = option
                self.menuButton.setTitle(titleProvider(option), for: .normal)
                self.onSelect?(option)
            }
        })
    }
}
