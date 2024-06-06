//
//  NewActivityTextFieldCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 18.04.2024.
//

import UIKit

class NewActivityTextFieldCell: UITableViewCell {

    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        label.lineBreakMode = .byTruncatingTail
        label.textColor = .darkGray
        return label
    }()
    
    lazy var body: RoundedTextField = {
        let body = RoundedTextField()
        body.font = .preferredFont(forTextStyle: .body)        
        body.backgroundColor = .systemGray6
        return body
    }()
    
    lazy var vStack: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.spacing = 10
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        vStack.addArrangedSubview(label)
        vStack.addArrangedSubview(body)
        contentView.addSubview(vStack)
        
        NSLayoutConstraint.activate([
            vStack.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            vStack.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            vStack.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            vStack.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
