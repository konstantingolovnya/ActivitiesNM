//
//  ActivitiesTableViewCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 26.02.2024.
//

import UIKit

class ActivitiesTableViewCell: UITableViewCell {
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var locationLabel: UILabel!
    @IBOutlet var typeLabel: UILabel!
    @IBOutlet var presentationImageView: UIImageView! {
        didSet {
            presentationImageView.layer.cornerRadius = 30
            presentationImageView.clipsToBounds = true
        }
    }
    @IBOutlet var favoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tintColor = .systemRed
    }
}
