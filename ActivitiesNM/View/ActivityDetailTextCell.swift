//
//  ActivityDetailTextCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 02.03.2024.
//

import UIKit

class ActivityDetailTextCell: UITableViewCell {
    
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 0
        }
    }
}
