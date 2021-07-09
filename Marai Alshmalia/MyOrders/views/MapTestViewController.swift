//
//  MapTestViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 10/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
class MapTestViewController: UIViewController, CLLocationManagerDelegate {
    
    static var longitudeValue : Double?
    let manager = CLLocationManager()
    var cityId : Int?
    //    var userId : [String:Int] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white
        GMSServices.provideAPIKey("AIzaSyBUCj9T8jCA8Cyj7eg1_4MwJcH2uJmHe2g")
        let camera = GMSCameraPosition.camera(withLatitude: 30.033333, longitude: 31.233334, zoom: 8.0)
        let mapView = GMSMapView.map(withFrame:  view.frame, camera: camera)
        view.addSubview(mapView)
        let cities = [
            city(name: "Sohag", id: 1, lat: 26.549999, long: 31.700001),
            city(name: "Cairo City City City", id: 2, lat: 30.033333, long: 31.233334),
            city(name: "Sherbeen", id: 3, lat: 31.192560, long: 31.520460),
            city(name: "Mansoura", id: 4, lat: 31.037933, long: 31.381523),
            city(name: "Damietta",id: 5, lat: 31.417540, long: 31.814444)
        ]
        
        
        for custonCity in cities {
            let cityMrker = PlaceMarker(latitude: custonCity.lat, longitude:custonCity.long, distance: 4, placeName: custonCity.name)
            // your google maps set your marker's map to it.
            //            let cityMrker = GMSMarker()
//            cityMrker.position = CLLocationCoordinate2D(latitude: custonCity.lat, longitude: custonCity.long)
//            cityMrker.title = custonCity.name
            cityMrker.zIndex = Int32(custonCity.id)
            //            cityMrker.iconView = Bundle.loadNibNamed(<#T##self: Bundle##Bundle#>)
            //            cityMrker.userData = ["id" : custonCity.id]
            //                let userData = cityMrker.userData as? [String:Int]
            cityMrker.map = mapView
            //            cityMrker.map = mapView
            
        }
        
        mapView.delegate = self
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }
}
extension MapTestViewController: GMSMapViewDelegate{
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        
        print(marker.zIndex)
        return true
    }
    
    //    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
    // print(marker.zIndex)
    //    }
}
// locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.first else{
//            return
//        }
//        let coordinate = location.coordinate
//        let camera = GMSCameraPosition.camera(withLatitude: coordinate.latitude, longitude: coordinate.longitude, zoom: 3.0)
//        let mapView = GMSMapView.map(withFrame:  view.frame, camera: camera)
//        view.addSubview(mapView)
////
////               let Marker1 = GMSMarker()
////               Marker1.position = CLLocationCoordinate2D(latitude: lat, longitude: long)
////               Marker1.title = name
////               Marker1.accessibilityLabel = "1"
////               Marker1.map = mapView
////
//
//        let marker = GMSMarker()
//        marker.position = coordinate
//        //                  marker.title = "London"
//        //                  marker.snippet = "Australia"
//        marker.map = mapView
//        TimeAndLocationViewController.setCoordinate(longitud: coordinate.longitude, latitude: coordinate.latitude)
////        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
////            self.dismiss(animated: true, completion: nil)
////        }
//    }

