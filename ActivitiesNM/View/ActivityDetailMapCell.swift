//
//  ActivityDetailMapCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 06.03.2024.
//

import UIKit
import MapKit

class ActivityDetailMapCell: UITableViewCell {
    
    private enum Constants {
        static let mapViewCornerRadius: CGFloat = 20.0
        static let mapViewHeight: CGFloat = 200.0
    }
    
     lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.layer.cornerRadius = Constants.mapViewCornerRadius
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: Constants.mapViewHeight).isActive = true
        return view
    }()
    
    func configure(with location: String) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(location) { [weak self] placemarks, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Geocoding error: \(error.localizedDescription)")
                return
            }
            
            guard let placemark = placemarks?.first, let location = placemark.location else {
                print("No placemarks found")
                return
            }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            
            let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
            
            self.mapView.addAnnotation(annotation)
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        contentView.addSubview(mapView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
