//
//  ActivityDetailView.swift
//  ActivitiesNM
//
//  Created by Konstantin on 11.04.2024.
//

import UIKit

class ActivityDetailView: UIView {
    
    private enum Constants {
        static let rateButtonTitle = "Оценить"
        static let rateButtonTitleColor = UIColor.white
        static let rateButtonFont = UIFont.preferredFont(forTextStyle: .headline)
        static let rateButtonBackgroundColor = UIColor(named: "Navigation Bar Title")
        static let cornerRadius: CGFloat = 20 // example value
    }
    
    lazy var headerView = ActivityDetailHeaderView()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var rateButton: UIButton = {
        let button = UIButton()
        button.setTitle(Constants.rateButtonTitle, for: .normal)
        button.setTitleColor(Constants.rateButtonTitleColor, for: .normal)
        button.titleLabel?.font = Constants.rateButtonFont
        button.backgroundColor = Constants.rateButtonBackgroundColor
        button.configuration?.cornerStyle = .capsule
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var buttonView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupTableView()
        setupButtonView()
        setupConstraints()
    }
    
    private func setupTableView() {
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = rateButton
        addSubview(tableView)
    }
    
    private func setupButtonView() {
        buttonView.addSubview(rateButton)
        addSubview(buttonView)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            rateButton.centerXAnchor.constraint(equalTo: buttonView.centerXAnchor),
            rateButton.centerYAnchor.constraint(equalTo: buttonView.centerYAnchor),
            rateButton.heightAnchor.constraint(equalToConstant: 44),
            rateButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
}

