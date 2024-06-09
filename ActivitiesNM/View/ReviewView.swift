//
//  ReviewView.swift
//  ActivitiesNM
//
//  Created by Konstantin on 17.04.2024.
//

import UIKit

class ReviewView: UIView {
    
    private enum Constants {
        static let buttonForegroundColor: UIColor = .black
        static let buttonBackgroundColor: UIColor = .darkGray
        static let buttonImage: UIImage? = UIImage(systemName: "xmark")
        static let buttonCornerStyle: UIButton.Configuration.CornerStyle = .capsule
        static let blurEffectStyle: UIBlurEffect.Style = .dark
        static let closeButtonTopConstant: CGFloat = 20
        static let closeButtonTrailingConstant: CGFloat = -20
    }

    lazy var backgroundImageView: UIImageView = {
       let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var closeButton: UIButton = {
        var configuration = UIButton.Configuration.tinted()
        configuration.baseForegroundColor = Constants.buttonForegroundColor
        configuration.background.backgroundColor = Constants.buttonBackgroundColor
        configuration.image = Constants.buttonImage
        configuration.cornerStyle = Constants.buttonCornerStyle
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var rateButtons: [UIButton] = {
        var buttons: [UIButton] = []
        for rating in Activity.Rating.allCases {
            var configuration = UIButton.Configuration.plain()
            configuration.image = UIImage(named: rating.image)
            configuration.title = rating.rawValue.capitalized
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
        let blurEffect = UIBlurEffect(style: Constants.blurEffectStyle)
        let effect = UIVisualEffectView(effect: blurEffect)
        effect.translatesAutoresizingMaskIntoConstraints = false
        return effect
    }()
    
    init() {
        super.init(frame: .zero)
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
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            blurEffect.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            blurEffect.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
            blurEffect.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            blurEffect.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            
            backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Constants.closeButtonTopConstant),
            closeButton.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: Constants.closeButtonTrailingConstant),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
