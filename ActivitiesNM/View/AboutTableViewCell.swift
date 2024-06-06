//
//  AboutTableViewCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 23.04.2024.
//

import UIKit

class AboutTableViewCell: UITableViewCell {

    lazy var title: UILabel = {
        let title = UILabel()
        title.font = .preferredFont(forTextStyle: .title3)
        title.baselineAdjustment = .alignBaselines
        title.lineBreakMode = .byTruncatingTail
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(title)
    }
}
