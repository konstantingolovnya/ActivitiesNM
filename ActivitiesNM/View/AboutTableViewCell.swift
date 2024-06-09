//
//  AboutTableViewCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 23.04.2024.
//

import UIKit

class AboutTableViewCell: UITableViewCell {

    private enum Constants {
        static let font: UIFont = .preferredFont(forTextStyle: .title3)
        static let baselineAdjustment: UIBaselineAdjustment = .alignBaselines
        static let lineBreakMode: NSLineBreakMode = .byTruncatingTail
    }
    
    lazy var title: UILabel = {
        let title = UILabel()
        title.font = Constants.font
        title.baselineAdjustment = Constants.baselineAdjustment
        title.lineBreakMode = Constants.lineBreakMode
//        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(title)
//        NSLayoutConstraint.activate([
//            title.topAnchor.constraint(equalTo: contentView.topAnchor),
//            title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
//        ])
    }
}

