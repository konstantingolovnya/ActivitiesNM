//
//  RoundedTextField.swift
//  ActivitiesNM
//
//  Created by Konstantin on 12.03.2024.
//

import UIKit

class RoundedTextField: UITextField {
    
    private enum Constants {
        static let textPadding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        static let cornerRadius: CGFloat = 10
        static let borderColor = UIColor.systemGray6.cgColor
        static let borderWidth: CGFloat = 1
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.textPadding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.textPadding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: Constants.textPadding)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = Constants.cornerRadius
        layer.borderColor = Constants.borderColor
        layer.borderWidth = Constants.borderWidth
        layer.masksToBounds = true
    }
}
