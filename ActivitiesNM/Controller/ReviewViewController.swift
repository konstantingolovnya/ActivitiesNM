//
//  ReviewViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 07.03.2024.
//

import UIKit

class ReviewViewController: UIViewController {
    
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var closeButton: UIButton!
    @IBOutlet var rateButtons: [UIButton]!
    
    var activity = Activity()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = UIImage(named: activity.name)
        
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let scaleUpTransform = CGAffineTransform(scaleX: 10, y: 10)
        
        for rateButton in rateButtons {
            rateButton.alpha = 0
            rateButton.transform = scaleUpTransform
        }
        
        let moveTopTransform = CGAffineTransform(translationX: 0, y: -200)
        
        closeButton.transform = moveTopTransform
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.closeButton.transform = .identity
        }
        
        for rateButton in rateButtons {
            UIView.animate(withDuration: 0.5) {
                rateButton.alpha = 1
                rateButton.transform = .identity
            }
        }
    }
}
