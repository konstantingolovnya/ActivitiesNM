//
//  ActivityDetailTwoColumnCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 02.03.2024.
//

import UIKit

class ActivityDetailTwoColumnCell: UITableViewCell {
    
    @IBOutlet var column1TitleLabel: UILabel! {
        didSet {
            column1TitleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var column1TextLabel: UILabel! {
        didSet {
            column1TextLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var column2TitleLabel: UILabel! {
        didSet {
            column2TitleLabel.numberOfLines = 0
        }
    }
    
    @IBOutlet var column2TextLabel: UILabel! {
        didSet {
            column2TextLabel.numberOfLines = 0
        }
    }
}
