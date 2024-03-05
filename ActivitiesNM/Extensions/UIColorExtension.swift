//
//  UIColorExtension.swift
//  ActivitiesNM
//
//  Created by Konstantin on 04.03.2024.
//

import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let redValue = CGFloat(red) / 255
        let greenValue = CGFloat(green) / 255
        let blueValue = CGFloat(blue) / 255
        self.init(red: redValue, green: greenValue, blue: blueValue, alpha: 1)
    }

    
}
