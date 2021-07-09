//
//  MapViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 06/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//
import CoreLocation
import UIKit
//import MapKit
import GoogleMaps
class MapViewController: UIViewController, CLLocationManagerDelegate {
//    @IBOutlet var mapView: MKMapView!
    static var latitudeValue : Double?
     static var longitudeValue : Double?
    let manager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white
//        GMSServices.provideAPIKey("AIzaSyC5Il4knWyFiHcN8C9985QPyTdCbUdxj8o")
//        ("AIzaSyCHU2_GH-RET2a6p5uVHYYNz9LpiTAQwPg")
        GMSServices.provideAPIKey("AIzaSyDCURXTWc8fMNq_UWMb3bRLYpA_zNyfFSQ")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else{
            return
//            manager.stopUpdatingLocation()
//            render(location)
        }
        let coordinate = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 3.0)
        
                 let mapView = GMSMapView.map(withFrame:  view.frame, camera: camera)
                  view.addSubview(mapView)
                  let marker = GMSMarker()
                    marker.position = coordinate
//                  marker.title = "London"
//                  marker.snippet = "Australia"
                  marker.map = mapView
        TimeAndLocationViewController.setCoordinate(longitud: coordinate.longitude, latitude: coordinate.latitude)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            self.dismiss(animated: true, completion: nil)
        }
    }
//    func coordinate(longitudeValue: Double, latitudeValue: Double) {
//        self.longitudeValue = longitudeValue
//        self.latitudeValue = latitudeValue
//    }
//    func render(_ location : CLLocation)   {
//        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
//        latitudeValue = location.coordinate.latitude
//        longitudeValue = location.coordinate.longitude
//        let region = MKCoordinateRegion(center: coordinate, span: span)
//        mapView.setRegion(region, animated: true)
//        let pin = MKPointAnnotation()
//        pin.coordinate =  coordinate
//        mapView.addAnnotation(pin)
//            let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "TimeAndLocationViewController") as? TimeAndLocationViewController
//            self.navigationController?.pushViewController(vc!, animated: true)
            
//        }
        
}
