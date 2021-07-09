//
//  MapMsgViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 01/04/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import CoreLocation
import UIKit
import GoogleMaps
import Kingfisher
import GooglePlaces
import Alamofire

protocol setLadLongValues {
    func setValues(msg : Messages)
}
class MapMsgViewController: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate {
    
    
    var delegate: setLadLongValues?
    var latitudeValue : Double?
    var longitudeValue : Double?
    let manager = CLLocationManager()
    static var messageLangLog : Messages?
    
    let googleKey = "AIzaSyDCURXTWc8fMNq_UWMb3bRLYpA_zNyfFSQ"
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var locationDesc: UILabel!
    
    @IBOutlet weak var searchBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = .blue
        self.navigationController?.navigationBar.tintColor = UIColor.blue
        mapView.isMyLocationEnabled = true
        
    }
    
    @IBAction func searchBtnPressed(_ sender: Any) {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self
        //        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
        //                                                    UInt(GMSPlaceField.placeID.rawValue))
        //        autocompleteController.placeFields = fields
        
        let filter = GMSAutocompleteFilter()
        filter.type = .address
        autocompleteController.autocompleteFilter = filter
        present(autocompleteController, animated: true, completion: nil)
    }
    @IBAction func txtFieldPressed(_ sender: Any) {
        
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        mapView.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.delegate = self
        manager.startUpdatingLocation()
        manager.requestWhenInUseAuthorization()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if CLLocationManager.locationServicesEnabled(){
            if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
                if manager.location != nil{
                    mapView.animate(to: GMSCameraPosition(latitude: manager.location!.coordinate.latitude, longitude:  manager.location!.coordinate.longitude, zoom: 17.0))
                }
            }
        }
    }
    
    @IBAction func sendBtnPressed(_ sender: Any) {
        
        let msg = Messages(messageBody: "", img: UIImage(), lat: latitudeValue, long: longitudeValue, type: "img")
        delegate?.setValues(msg: msg)
        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let lat = position.target.latitude
        let long = position.target.longitude
        
        self.latitudeValue = lat
        self.longitudeValue = long
        
    }
    
    
}
extension MapMsgViewController : GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        //        searchBtn.setTitle(place.name!, for: .normal)
        latitudeValue = place.coordinate.latitude
        longitudeValue = place.coordinate.longitude
        mapView.animate(to: GMSCameraPosition(latitude: latitudeValue!, longitude: longitudeValue! , zoom: 17.0))
        locationDesc.text = place.name
        //        print("Place name: \(String(describing: place.name))")
        //        print("Place ID: \(String(describing: place.placeID))")
        //        print("Place attributions: \(String(describing: place.attributions))")
        dismiss(animated: true, completion: nil)
    }
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error: ", error.localizedDescription)
    }
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
          if let location = locations.first {
            latitudeValue = location.coordinate.latitude
            longitudeValue = location.coordinate.longitude
          }
      }
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        if let location = locations.last{
//            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
//            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
//            self.map.setRegion(region, animated: true)
//        }
//    }
    
    

//    func getLocationName(lat:Double,long:Double){
//        AF.request("https://maps.googleapis.com/maps/api/geocode/json?latlng=" + "\((lat) ),\((long) )&key=\(googleKey)").responseData(completionHandler: { (response) in
//            debugPrint(response)
//        })
//    }
    
  
    
}
