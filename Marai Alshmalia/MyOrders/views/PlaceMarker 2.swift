//
//  PlaceMarker.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 10/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
import GoogleMaps

class PlaceMarker: GMSMarker {
    
    init(latitude: Double, longitude: Double , distance: Double, placeName: String) {
        super.init()
        //        if let lat: CLLocationDegrees = latitude,
        //                 let long: CLLocationDegrees = longitude {
        let lat: CLLocationDegrees = latitude
        let long: CLLocationDegrees = longitude
        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        position = coordinate
        //        }
        
        let view = Bundle.main.loadNibNamed("MarkerInfoView", owner: nil, options: nil)?.first as! MarkerView
        view.markerLabel.text = placeName
        
        //        view.markerLabel.font.withSize(9)
        iconView = view
        appearAnimation = .pop //not necessarily but looks nice.
    }
}
