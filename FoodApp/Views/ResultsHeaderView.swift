////
////  ResultHeaderView.swift
////  FoodApp
////
////  Created by Timmy Nguyen on 5/4/25.
////
//
//import UIKit
//
//protocol ResultsHeaderViewDelegate: AnyObject {
//    func resultsHeaderView(_ sender: ResultsHeaderView, didTapInSection section: ResultsTableViewController.Section)
//}
//
//class ResultsHeaderView: UITableViewHeaderFooterView {
//    static let reuseIdentifier = "ResultsHeaderView"
//
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
//        label.textColor = .secondaryLabel
//        return label
//    }()
//    
//    lazy private var seeMoreButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(
//            UIImage(
//                systemName: "chevron.right",
//                withConfiguration: UIImage.SymbolConfiguration(pointSize: 10, weight: .regular)
//            ),
//            for: .normal
//        )
//        button.tintColor = .secondaryLabel
//        button.addAction(didTapSeeMoreButton(), for: .touchUpInside)
//        return button
//    }()
//    
//    private let container: UIStackView = {
//        let stackView = UIStackView()
//        stackView.axis = .horizontal
//        stackView.alignment = .center
//        stackView.distribution = .fill
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        return stackView
//    }()
//
//    var section: ResultsTableViewController.Section?
//    weak var delegate: ResultsHeaderViewDelegate?
//    
//    override init(reuseIdentifier: String?) {
//        super.init(reuseIdentifier: reuseIdentifier)
//        contentView.addSubview(container)
//        
//        // Add arranged subviews in order
//        container.addArrangedSubview(titleLabel)
//        container.addArrangedSubview(seeMoreButton)
//        
//        // Constraints to layoutMargins (14 left, dynamic top/bottom)
//        NSLayoutConstraint.activate([
//            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
//            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
//            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
//            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
//        ])
//        
//        // Ensure title hugs and truncates, button stays fixed
//        titleLabel.setContentHuggingPriority(.defaultLow,  for: .horizontal)
//        titleLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
//        seeMoreButton.setContentHuggingPriority(.required,     for: .horizontal)
//        seeMoreButton.setContentCompressionResistancePriority(.required, for: .horizontal)
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func update(title: String) {
//        titleLabel.text = title.uppercased()
//    }
//    
//    func didTapSeeMoreButton() -> UIAction {
//        return UIAction { _ in
//            guard let section = self.section else { return }
//            self.delegate?.resultsHeaderView(self, didTapInSection: section)
//        }
//    }
//}
