//
//  ActivityDetailMapCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 06.03.2024.
//

import UIKit
import MapKit

class ActivityDetailMapCell: UITableViewCell {
    
   lazy var mapView: MKMapView = {
        let view = MKMapView()
            view.layer.cornerRadius = 20
       view.translatesAutoresizingMaskIntoConstraints = false
       view.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return view
    }()
    
    func configure(location: String) {
        let geoCoder = CLGeocoder()
        
        geoCoder.geocodeAddressString(location) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                let annotation = MKPointAnnotation()
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    let region = MKCoordinateRegion(center: annotation.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
                    
                    self.mapView.addAnnotation(annotation)
                    self.mapView.setRegion(region, animated: true)
                }
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.contentView.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.contentView.layoutMarginsGuide.bottomAnchor)
        ])
    }
}
