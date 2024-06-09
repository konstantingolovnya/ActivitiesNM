//
//  NewActivityDescriptionTextCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 18.04.2024.
//

import UIKit

class NewActivityDescriptionTextCell: UITableViewCell {
    
    private enum Constants {
        static let labelFont: UIFont = .preferredFont(forTextStyle: .headline)
        static let labelTextColor: UIColor = .darkGray
        static let labelLineBreakMode: NSLineBreakMode = .byTruncatingTail
        static let textViewFont: UIFont = .preferredFont(forTextStyle: .body)
        static let textViewBackgroundColor: UIColor = .systemGray6
        static let textViewCornerRadius: CGFloat = 10
        static let textViewHeight: CGFloat = 100
        static let stackViewSpacing: CGFloat = 10
    }

    lazy var label: UILabel = {
        let label = UILabel()
        label.font = Constants.labelFont
        label.lineBreakMode = Constants.labelLineBreakMode
        label.textColor = Constants.labelTextColor
        return label
    }()
    
    lazy var body: UITextView = {
        let body = UITextView()
        body.font = Constants.textViewFont
        body.layer.cornerRadius = Constants.textViewCornerRadius
        body.backgroundColor = Constants.textViewBackgroundColor
        body.translatesAutoresizingMaskIntoConstraints = false
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
            body.heightAnchor.constraint(equalToConstant: Constants.textViewHeight),
            vStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
