//
//  MapViewController.swift
//  ActivitiesNM
//
//  Created by Konstantin on 06.03.2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    lazy var mapView = MKMapView()
    
    var activity: Activity!
    
    //MARK: - View controller life cycle
    override func loadView() {
        view = mapView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geocodeActivityLocation()
        setupMapView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    //MARK: - Setup Methods
    private func setupMapView() {
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
    }
    
    private func geocodeActivityLocation() {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(activity.location) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks, let placemark = placemarks.first, let location = placemark.location else {
                return
            }
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = location.coordinate
            annotation.title = self.activity.name
            annotation.subtitle = self.activity.type
            
            self.mapView.showAnnotations([annotation], animated: true)
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
}

//MARK: - MKMapViewDelegate Protocol
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView?.glyphText = "🤩"
        annotationView?.markerTintColor = UIColor.systemOrange
        
        return annotationView
    }
}
