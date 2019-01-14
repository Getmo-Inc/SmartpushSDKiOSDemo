//
//  Geofence.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 08/01/19.
//  Copyright © 2019 Getmo. All rights reserved.
//

import Foundation
import GoogleMaps

class Geofence {
    
    func createGeofence (identifier:String, latitude:Double, longitude:Double, map:GMSMapView, locationManager:CLLocationManager) {
        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: location, radius: 100, identifier: identifier)
        locationManager.startMonitoring(for: geoFenceRegion)
        
        let cirlce = GMSCircle(position: location, radius: 100)
        cirlce.fillColor = UIColor.blue.withAlphaComponent(0.5)
        cirlce.map = map
        
    }
    
}
