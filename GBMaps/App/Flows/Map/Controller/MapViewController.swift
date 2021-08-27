//
//  MapViewController.swift
//  GBMaps
//
//  Created by Илья Кадыров on 26.08.2021.
//

import UIKit
import GoogleMaps
import CoreLocation

class MapViewController: UIViewController {
    // Центр Москвы
    let startCoordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var locationManager: CLLocationManager?
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBAction func currentLocation(_ sender: Any) {
        locationManager?.requestLocation()
    }
    
    @IBAction func toggleTrack(_ sender: Any) {
        locationManager?.startUpdatingLocation()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()
        checkLocationStatus()
    }

    func configureLocationManager() {
            locationManager = CLLocationManager()
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.delegate = self
        }
    
    func configureMap() {
        // Создаём камеру с использованием координат и уровнем увеличения
        let camera = GMSCameraPosition.camera(withTarget: startCoordinate, zoom: 17)
        // Устанавливаем камеру для карты
        mapView.camera = camera
        mapView.delegate = self
    }
    
    func addMarker(coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
        }
    
    private func checkLocationStatus() {
        let locationStatus = locationManager?.authorizationStatus
        switch locationStatus {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            debugPrint("denied access location by user")
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
        default:
            break
        }
    }
}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {

        }
}

extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let coordinate = locations.last?.coordinate else {
            return
        }
        self.addMarker(coordinate: coordinate)
        mapView.animate(toLocation: coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

