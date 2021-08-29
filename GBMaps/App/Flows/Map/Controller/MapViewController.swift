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
    
    let rPointService = RPointService()
    // Центр Москвы
    let startCoordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var locationManager: CLLocationManager?
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    var trackStatus: StatusTrackEnum = .initial
    
    @IBOutlet weak var mapView: GMSMapView!
    
//    @IBAction func currentLocation(_ sender: Any) {
//        locationManager?.requestLocation()
//    }
    
    @IBAction func startTrackAction(_ sender: Any) {
        trackStatus = .start
        createNewPath()
        startUpdate()
    }
    
    func startUpdate() {
        // Запускаем отслеживание или продолжаем, если оно уже запущено
            locationManager?.startUpdatingLocation()
            locationManager?.startMonitoringSignificantLocationChanges()
    }
    func stopUpdate() {
        locationManager?.stopUpdatingLocation()
        locationManager?.stopMonitoringSignificantLocationChanges()
    }
    
    @IBAction func finishTrackAction(_ sender: Any) {
        finishTrack()
    }
    
    func createNewPath() {
        // Отвязываем от карты старую линию
            route?.map = nil
        // Заменяем старую линию новой
            route = GMSPolyline()
        // Заменяем старый путь новым, пока пустым (без точек)
            routePath = GMSMutablePath()
        // Добавляем новую линию на карту
            route?.map = mapView
    }
    
    func addCoordinateToPath(points: [CLLocationCoordinate2D]) {
        for point in points {
            routePath?.add(point)
        }
        route?.path = routePath
    }
    
    func finishTrack() {
        trackStatus = .finish
        stopUpdate()
        guard let routePath = routePath else {return}
        rPointService.deleteAll()
        for indexPoint in 0..<routePath.count() {
            rPointService.save(point: routePath.coordinate(at: indexPoint))
        }
    }
    
    @IBAction func previousTrackAction(_ sender: Any) {
        stopUpdate()
        if trackStatus == .start {
            let handler = { (action: UIAlertAction) -> Void in
                self.finishTrack()
            }
            createAlert(text: "Get previous path?", handler: handler)
        }
        let previousPoints = rPointService.load()
        guard previousPoints.count > 0 else {
            createAlert(text: "Not data", handler: nil)
            return
        }
        self.createNewPath()
        self.addCoordinateToPath(points: previousPoints)
        let bounds = GMSCoordinateBounds(path: routePath!)
        self.mapView.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 50.0))
        
    }
    
    private func createAlert(text: String, handler: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: "Message", message: text, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .default, handler: handler)
        alert.addAction(actionOk)
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureMap()
        configureLocationManager()
        checkLocationStatus()
    }

    func configureLocationManager() {
            locationManager = CLLocationManager()
            locationManager?.allowsBackgroundLocationUpdates = true
            locationManager?.pausesLocationUpdatesAutomatically = false
            locationManager?.delegate = self
            locationManager?.requestAlwaysAuthorization()
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
        addCoordinateToPath(points: [coordinate])
        mapView.animate(toLocation: coordinate)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}

