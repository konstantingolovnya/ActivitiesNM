//
//  NewActivityPhotoCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 18.04.2024.
//

import UIKit

class NewActivityPhotoCell: UITableViewHeaderFooterView {

    private enum Constants {
        static let photoImage: UIImage? = UIImage(named: "newphoto")
        static let photoCornerRadius: CGFloat = 10
        static let photoBackgroundColor: UIColor = .systemGray6
        static let photoHeight: CGFloat = 200
    }

    lazy var photoImageView: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.layer.cornerRadius = Constants.photoCornerRadius
        photo.layer.masksToBounds = true
        photo.image = Constants.photoImage
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.backgroundColor = Constants.photoBackgroundColor
        return photo
    }()
    
    var tapHandler: ((NewActivityPhotoCell) -> Void)?
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        setup()
    }
    
    @objc private func tapAction() {
        tapHandler?(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(photoImageView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: Constants.photoHeight),
            photoImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
