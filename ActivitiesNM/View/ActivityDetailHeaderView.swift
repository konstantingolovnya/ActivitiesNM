//
//  ActivityDetailHeaderView.swift
//  ActivitiesNM
//
//  Created by Konstantin on 01.03.2024.
//

import UIKit

class ActivityDetailHeaderView: UITableViewHeaderFooterView {
    
    private enum Constants {
        static let nameLabelFontSize: CGFloat = 40
        static let typeLabelFontSize: CGFloat = 20
        static let ratingImageSize: CGSize = CGSize(width: 52, height: 50)
        static let stackViewSpacing: CGFloat = 10
        static let stackViewLeadingInset: CGFloat = 20
        static let stackViewTrailingInset: CGFloat = -150
        static let stackViewBottomInset: CGFloat = -20
        static let ratingImageTrailingInset: CGFloat = -20
    }
    
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
        if let customFont = UIFont(name: "Nunito-Bold", size: Constants.nameLabelFontSize) {
            label.font = UIFontMetrics(forTextStyle: .title1).scaledFont(for: customFont)
        }
        return label
    }()
    
    lazy var typeLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .preferredFont(forTextStyle: .headline)
        if let customFont = UIFont(name: "Nunito-Regular", size: Constants.typeLabelFontSize) {
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
        view.spacing = Constants.stackViewSpacing
        view.distribution = .fill
        view.contentMode = .scaleToFill
        return view
    }()
    
    var tapHandler: ((ActivityDetailHeaderView) -> Void)!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            labelStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.stackViewLeadingInset),
            labelStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.stackViewTrailingInset),
            labelStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Constants.stackViewBottomInset),
            
            ratingImage.heightAnchor.constraint(equalToConstant: Constants.ratingImageSize.height),
            ratingImage.widthAnchor.constraint(equalToConstant: Constants.ratingImageSize.width),
            ratingImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Constants.ratingImageTrailingInset),
            ratingImage.bottomAnchor.constraint(equalTo: labelStackView.bottomAnchor)
        ])
    }
}

