//
//  RPointService.swift
//  GBMaps
//
//  Created by Илья Кадыров on 28.08.2021.
//

import Foundation
import RealmSwift
import CoreLocation

class RPointService {
    
    let realmSetting = RealmSetting()
    let realm: Realm
    
    init() {
        realm = realmSetting.getRealm()
    }
    
    func save(point: CLLocationCoordinate2D) {
        realm.beginWrite()
        do {
           let rPoint = RPoint()
           rPoint.latitude = point.latitude
           rPoint.longitude = point.longitude
           realm.add(rPoint)
            
            try realm.commitWrite()
            } catch {
            debugPrint(error)
            }
    }
    
    func saveAll(pointList: [CLLocationCoordinate2D]) {
        realm.beginWrite()
        do {
            for point in pointList {
                let rPoint = RPoint()
                rPoint.latitude = point.latitude
                rPoint.longitude = point.longitude
                realm.add(rPoint)
                }
            try realm.commitWrite()
            } catch {
            debugPrint(error)
            }
    }
    
    func checkExist(date: Date) -> Bool{
        if self.getByDate(date: date) != nil {
            return true
        } else {
            return false
        }
    }
    
    func getByDate(date: Date) -> RPoint? {
        return realm.objects(RPoint.self).filter("dateAdded == %@", date).first
    }
    
    func load() -> [CLLocationCoordinate2D] {
        return realm.objects(RPoint.self).map{RPoint.toCoordinate2D(rPoint: $0)}
    }
    
    func deleteAll() {
        let objectsToDelete = realm.objects(RPoint.self)
        realm.beginWrite()
        do {
            realm.delete(objectsToDelete)
            try realm.commitWrite()
        } catch {
            debugPrint(error)
        }
        
    }
    
    func loadResult() -> Results<RPoint> {
        return realm.objects(RPoint.self)
    }
    
}

