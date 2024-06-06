//
//  ActivityDetailTwoColumnCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 02.03.2024.
//

import UIKit

class ActivityDetailTwoColumnCell: UITableViewCell {
    
    lazy var column1TitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var column1TextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var column2TitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var column2TextLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var column1StackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 10
        return view
    }()
    
    lazy var column2StackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .fill
        view.distribution = .equalSpacing
        view.spacing = 10
        return view
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.alignment = .top
        view.distribution = .fillEqually
        view.spacing = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        column1StackView.addArrangedSubview(column1TitleLabel)
        column1StackView.addArrangedSubview(column1TextLabel)
        column2StackView.addArrangedSubview(column2TitleLabel)
        column2StackView.addArrangedSubview(column2TextLabel)
        stackView.addArrangedSubview(column1StackView)
        stackView.addArrangedSubview(column2StackView)
        self.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
            ])
    }
}
