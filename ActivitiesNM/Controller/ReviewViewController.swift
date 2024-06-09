//
//  ReviewViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 07.03.2024.
//

import UIKit

protocol RateActivityDelegate: AnyObject {
    func rateActivity(rating: String)
}

class ReviewViewController: UIViewController {
    
    var mainView = ReviewView()
    var activity: Activity!
    weak var delegate: RateActivityDelegate?

    //MARK: - View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mainView)
        mainView.frame.size = view.bounds.size
        mainView.backgroundImageView.image = UIImage(data: activity.image)
        
        setupRateButtons()
        setupCloseButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        animateButtons()
    }
    
    //MARK: - Setup Methods
    private func setupRateButtons() {
        let scaleUpTransform = CGAffineTransform(scaleX: 10, y: 10)
        
        for rateButton in mainView.rateButtons {
            rateButton.alpha = 0
            rateButton.transform = scaleUpTransform
            
            let action = UIAction { action in
                if let rating = rateButton.configuration?.title {
                    self.delegate?.rateActivity(rating: rating)
                }
            }
            rateButton.addAction(action, for: .touchUpInside)
        }
    }
    
    private func setupCloseButton() {
        let moveTopTransform = CGAffineTransform(translationX: 0, y: -200)
        mainView.closeButton.transform = moveTopTransform
        
        let closeButtonAction = UIAction { action in
            self.dismiss(animated: true)
        }
        mainView.closeButton.addAction(closeButtonAction, for: .touchUpInside)
    }
    
    private func animateButtons() {
        UIView.animate(withDuration: 0.5) {
            self.mainView.closeButton.transform = .identity
        }
        
        for rateButton in mainView.rateButtons {
            UIView.animate(withDuration: 0.5) {
                rateButton.alpha = 1
                rateButton.transform = .identity
            }
        }
    }
}
