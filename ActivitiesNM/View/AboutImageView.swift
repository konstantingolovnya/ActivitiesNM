//
//  AboutView.swift
//  ActivitiesNM
//
//  Created by Konstantin on 23.04.2024.
//

import UIKit

class AboutImageView: UIView {

    private enum Constants {
        static let imageName: String = "about"
        static let imageContentMode: UIView.ContentMode = .scaleAspectFit
    }
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        image.contentMode = Constants.imageContentMode
        image.image = UIImage(named: Constants.imageName)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(image)
        setupConstraints()
    }
        
        private func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
