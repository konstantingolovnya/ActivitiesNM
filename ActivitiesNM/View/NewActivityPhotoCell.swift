//
//  NewActivityPhotoCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 18.04.2024.
//

import UIKit

class NewActivityPhotoCell: UITableViewHeaderFooterView {

    lazy var photoImageView: UIImageView = {
        let photo = UIImageView()
        photo.contentMode = .scaleAspectFill
        photo.layer.cornerRadius = 10
        photo.layer.masksToBounds = true
        photo.image = UIImage(named: "newphoto")
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.backgroundColor = .systemGray6

        return photo
    }()
    
    var tapHandler: ((NewActivityPhotoCell) -> Void)!
    
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
        contentView.addSubview(photoImageView)
        
        NSLayoutConstraint.activate([
            photoImageView.heightAnchor.constraint(equalToConstant: 200),
            photoImageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
        ])
    }
}
