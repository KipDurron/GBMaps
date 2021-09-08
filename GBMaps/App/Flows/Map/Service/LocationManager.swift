//
//  LocationManager.swift
//  GBMaps
//
//  Created by Илья Кадыров on 02.09.2021.
//

import Foundation
import CoreLocation
import RxSwift
import RxRelay

final class LocationManager: NSObject {
    static let instance = LocationManager()
    
    private override init() {
        super.init()
        configureLocationManager()
    }
    
    let locationManager = CLLocationManager()
    
    let location: BehaviorSubject<CLLocation?> = BehaviorSubject(value: nil)
    
    func startUpdatingLocation() {
        locationManager.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
        locationManager.stopMonitoringSignificantLocationChanges()
    }
    
    private func configureLocationManager() {
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    func checkLocationStatus() {
        let locationStatus = locationManager.authorizationStatus
        switch locationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted, .denied:
            debugPrint("denied access location by user")
        default:
            break
        }
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        self.location.onNext(location)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
