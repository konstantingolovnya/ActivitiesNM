//
//  NewActivityTextFieldCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 18.04.2024.
//

import UIKit

class NewActivityTextFieldCell: UITableViewCell {

    private enum Constants {
        static let labelFont: UIFont = .preferredFont(forTextStyle: .headline)
        static let labelTextColor: UIColor = .darkGray
        static let labelLineBreakMode: NSLineBreakMode = .byTruncatingTail
        static let textFieldFont: UIFont = .preferredFont(forTextStyle: .body)
        static let textFieldBackgroundColor: UIColor = .systemGray6
        static let stackViewSpacing: CGFloat = 10
    }

    lazy var label: UILabel = {
        let label = UILabel()
        label.font = Constants.labelFont
        label.lineBreakMode = Constants.labelLineBreakMode
        label.textColor = Constants.labelTextColor
        return label
    }()
    
    lazy var body: RoundedTextField = {
        let body = RoundedTextField()
        body.font = Constants.textFieldFont
        body.backgroundColor = Constants.textFieldBackgroundColor
        return body
    }()
    
    lazy var vStack: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = Constants.stackViewSpacing
        view.alignment = .fill
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
    
    private func setup() {
        vStack.addArrangedSubview(label)
        vStack.addArrangedSubview(body)
        contentView.addSubview(vStack)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
