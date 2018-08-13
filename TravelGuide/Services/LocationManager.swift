//
//  LocationManager.swift
//  TravelGuide
//
//  Created by Anton Makarov on 30/07/2018.
//  Copyright © 2018 Anton Makarov. All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    
    static let sharedInstance = LocationManager()
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    private override init(){
        super.init()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 50
        locationManager.allowsBackgroundLocationUpdates = false
        locationManager.startUpdatingLocation()
    }
    
    func checkPermissions() {
        if (!CLLocationManager.locationServicesEnabled() || CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied) {
            locationManager.requestAlwaysAuthorization()
        }
    }
    
    func startLocation() {
        checkPermissions()
        locationManager.startUpdatingLocation()
    }
    
    func stopLocation() {
        locationManager.stopUpdatingLocation()
    }
}

// CLLocationManagerDelegate
extension LocationManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("LocationManager failed with error: \(error.localizedDescription)")
    }
}
