//
//  ReviewView.swift
//  ActivitiesNM
//
//  Created by Konstantin on 17.04.2024.
//

import UIKit

class ReviewView: UIView {
    
    lazy var backgroundImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var closeButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.baseForegroundColor = .black
        configuration.background.backgroundColor = .darkGray
        configuration.image = UIImage(systemName: "xmark")
        configuration.cornerStyle = .capsule
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rateButtons: [UIButton] = {
        var buttons: [UIButton] = []
        for rating in Activity.Rating.allCases {
            var configuration = UIButton.Configuration.plain()
            configuration.image = UIImage(named: rating.image)
            configuration.title = rating.rawValue.capitalized  //!
            configuration.baseForegroundColor = .white
            configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer({ incoming in
                var outgoing = incoming
                outgoing.font = .preferredFont(forTextStyle: .largeTitle)
                return outgoing
            })
            let button = UIButton(configuration: configuration)
            buttons.append(button)
        }
        return buttons
    }()
    
    lazy var vStack: UIStackView = {
       let view = UIStackView()
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fill
        view.contentMode = .scaleToFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var blurEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let effect = UIVisualEffectView(effect: blurEffect)
        effect.translatesAutoresizingMaskIntoConstraints = false
        return effect
    }()
    
    init() {
        super .init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundImageView.addSubview(blurEffect)
        addSubview(backgroundImageView)
        addSubview(closeButton)
        for button in rateButtons {
            vStack.addArrangedSubview(button)
        }
        addSubview(vStack)
        
        NSLayoutConstraint.activate([
            blurEffect.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            blurEffect.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            blurEffect.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            blurEffect.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
//            closeButton.widthAnchor.constraint(equalToConstant: 20),
//            closeButton.heightAnchor.constraint(equalToConstant: 20),
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
