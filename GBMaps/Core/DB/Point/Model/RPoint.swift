//
//  RPoint.swift
//  GBMaps
//
//  Created by Илья Кадыров on 28.08.2021.
//

import Foundation
import CoreLocation
import RealmSwift
class RPoint: Object {
    @objc dynamic var latitude: Double = 0.0
    @objc dynamic var longitude: Double = 0.0
    @objc dynamic var dateAdded: Date = Date()
    
    static func toCoordinate2D(rPoint: RPoint) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: rPoint.latitude, longitude: rPoint.longitude)
    }
}
