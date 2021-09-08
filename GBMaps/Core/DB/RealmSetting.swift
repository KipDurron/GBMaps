//
//  RealmSetting.swift
//  ForVK
//
//  Created by Илья Кадыров on 14.10.2020.
//  Copyright © 2020 Илья Ишунин. All rights reserved.
//

import Foundation
import RealmSwift
class RealmSetting {
    let realm: Realm
    init() {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)
            self.realm = try Realm(configuration: config)
            debugPrint(realm.configuration.fileURL)
        } catch {
            debugPrint(error)
            fatalError("Error with Realm")
        }
    }
    
    func getRealm() -> Realm {
        return realm
    }
}
