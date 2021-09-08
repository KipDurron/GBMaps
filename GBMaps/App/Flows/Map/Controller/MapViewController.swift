//
//  MapViewController.swift
//  GBMaps
//
//  Created by Илья Кадыров on 26.08.2021.
//

import UIKit
import GoogleMaps
import CoreLocation
import RxSwift

class MapViewController: UIViewController {
    
    let rPointService = RPointService()
    // Центр Москвы
    let startCoordinate = CLLocationCoordinate2D(latitude: 55.753215, longitude: 37.622504)
    var route: GMSPolyline?
    var routePath: GMSMutablePath?
    var trackStatus: StatusTrackEnum = .initial
    let locationManager = LocationManager.instance
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var mapView: GMSMapView!
    
    @IBAction func startTrackAction(_ sender: Any) {
        trackStatus = .start
        createNewPath()
        locationManager.startUpdatingLocation()
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
        locationManager.stopUpdatingLocation()
        guard let routePath = routePath else {return}
        rPointService.deleteAll()
        for indexPoint in 0..<routePath.count() {
            rPointService.save(point: routePath.coordinate(at: indexPoint))
        }
    }
    
    @IBAction func previousTrackAction(_ sender: Any) {
        locationManager.stopUpdatingLocation()
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
        locationManager.checkLocationStatus()
        configureLocationManagerSubscribe()
    }

    
    func configureMap() {
        // Создаём камеру с использованием координат и уровнем увеличения
        let camera = GMSCameraPosition.camera(withTarget: startCoordinate, zoom: 17)
        // Устанавливаем камеру для карты
        mapView.camera = camera
        mapView.delegate = self
    }
    
    func configureLocationManagerSubscribe() {
           locationManager
               .location
               .asObservable()
            .subscribe(onNext: { [weak self] location in
                guard let location = location else { return }
                self?.addCoordinateToPath(points: [location.coordinate])
                self?.mapView.animate(toLocation: location.coordinate)
               }).disposed(by: disposeBag)
    }
    
    func addMarker(coordinate: CLLocationCoordinate2D) {
        let marker = GMSMarker(position: coordinate)
        marker.map = mapView
        }
    

}

extension MapViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {

        }
}


