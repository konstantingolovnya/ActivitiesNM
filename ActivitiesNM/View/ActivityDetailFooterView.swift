//
//  ActivityDetailFooterView.swift
//  ActivitiesNM
//
//  Created by Konstantin on 15.04.2024.
//

import UIKit

class ActivityDetailFooterView: UIView {
    
    lazy var rateButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Оценить"
        configuration.baseForegroundColor = .white
        configuration.baseBackgroundColor = UIColor(named: "NavigationBarTitle")
        configuration.cornerStyle = .capsule
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
            var outgoing = incoming
            outgoing.font = .preferredFont(forTextStyle: .headline)
            return outgoing
        })
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(rateButton)
        
        NSLayoutConstraint.activate([
            rateButton.topAnchor.constraint(equalTo: topAnchor),
            rateButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            rateButton.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            rateButton.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor)
        ])
    }
    
}
