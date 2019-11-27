//
//  LocationViewController.swift
//  BackgroundApp
//
//  Created by AikOganisyan on 25/11/2019.
//  Copyright © 2019 icos. All rights reserved.
//
import MapKit
import UIKit

class LocationViewController: UIViewController {
    
    private let locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMap()
        addMapTrackingButton()
    }
    
    private func setupMap() {
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
    
    func addMapTrackingButton() {
        if #available(iOS 11.0, *) {
            let buttonItem = MKUserTrackingButton(mapView: mapView)
            buttonItem.frame = CGRect(origin: CGPoint(x:5, y: 25), size: CGSize(width: 35, height: 35))
            mapView.addSubview(buttonItem)
        }
    }
    
    private func setPins(on locations: [CLLocation]) {
        locations.forEach {
            let annotation = MKPointAnnotation()
            let centerCoordinate = CLLocationCoordinate2D(latitude: $0.coordinate.latitude, longitude: $0.coordinate.longitude)
            annotation.coordinate = centerCoordinate
            annotation.title = "Title"
            mapView.addAnnotation(annotation)
            print("Pin was added")
        }
    }

}

extension LocationViewController: MKMapViewDelegate {
    
}

extension LocationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        setPins(on: locations)
    }
}
