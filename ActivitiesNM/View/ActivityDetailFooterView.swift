//
//  ActivityDetailFooterView.swift
//  ActivitiesNM
//
//  Created by Konstantin on 15.04.2024.
//

import UIKit

class ActivityDetailFooterView: UIView {
    
    private enum Constants {
        static let rateButtonTitle = "Оценить"
        static let rateButtonFont = UIFont.preferredFont(forTextStyle: .headline)
        static let rateButtonForegroundColor = UIColor.white
        static let rateButtonBackgroundColor = UIColor(named: "NavigationBarTitle")
        static let rateButtonCornerStyle = UIButton.Configuration.CornerStyle.capsule
    }
    
    lazy var rateButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = Constants.rateButtonTitle
        configuration.baseForegroundColor = Constants.rateButtonForegroundColor
        configuration.baseBackgroundColor = Constants.rateButtonBackgroundColor
        configuration.cornerStyle = Constants.rateButtonCornerStyle
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = Constants.rateButtonFont
            return outgoing
        })
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(rateButton)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            rateButton.topAnchor.constraint(equalTo: topAnchor),
            rateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            rateButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            rateButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
}

