//
//  ActivityDetailHeaderView.swift
//  ActivitiesNM
//
//  Created by Konstantin on 01.03.2024.
//

import UIKit

class ActivityDetailHeaderView: UIView {
    
    @IBOutlet var headerImageView: UIImageView!
    
    @IBOutlet var nameLabel: UILabel! {
        didSet {
            nameLabel.numberOfLines = 0
            
            if let customFont = UIFont(name: "Nunito-Bold", size: 40) {
                nameLabel.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
            }
        }
    }
    
    @IBOutlet var typeLabel: UILabel! {
        didSet {
            typeLabel.numberOfLines = 0
            
            if let customFont = UIFont(name: "Nunito-Regular", size: 20) {
                typeLabel.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
            }
        }
    }
    
    @IBOutlet var heartButton: UIButton!
    @IBOutlet var ratingImage: UIImageView!
}
