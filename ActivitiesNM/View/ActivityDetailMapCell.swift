//
//  ActivityDetailMapCell.swift
//  ActivitiesNM
//
//  Created by Konstantin on 06.03.2024.
//

import UIKit
import MapKit

class ActivityDetailMapCell: UITableViewCell {
    
    @IBOutlet var mapView: MKMapView! {
        didSet {
            mapView.layer.cornerRadius = 20
        }
    }
    
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
}
