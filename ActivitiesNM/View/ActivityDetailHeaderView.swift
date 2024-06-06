//
//  ActivityDetailHeaderView.swift
//  ActivitiesNM
//
//  Created by Konstantin on 01.03.2024.
//

import UIKit

class ActivityDetailHeaderView: UITableViewHeaderFooterView {
    
    lazy var headerImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .title1)
        if let customFont = UIFont(name: "Nunito-Bold", size: 40) {
            label.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
        }
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .headline)
        if let customFont = UIFont(name: "Nunito-Regular", size: 20) {
            label.font = UIFontMetrics(forTextStyle: .headline).scaledFont(for: customFont)
        }
        return label
    }()
    
    lazy var ratingImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    lazy var labelStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.axis = .vertical
        view.alignment = .leading
        view.spacing = 10
        view.distribution = .fill
        view.contentMode = .scaleToFill
        return view
    }()
    
    var tapHandler: ((ActivityDetailHeaderView) -> Void)!
    
//    override init(frame: CGRect) {
//        super .init(frame: frame)
//        setup()
//    }
    
    override init(reuseIdentifier: String?) {
        super .init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        setup()
    }
    
    @objc func tapAction() {
        tapHandler?(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubview(headerImageView)
        labelStackView.addArrangedSubview(nameLabel)
        labelStackView.addArrangedSubview(typeLabel)
        addSubview(labelStackView)
        addSubview(ratingImage)
        
        ratingImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        ratingImage.widthAnchor.constraint(equalToConstant: 52).isActive = true
        
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -150),
            labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            ratingImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            ratingImage.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor)
        ])
    }
}
