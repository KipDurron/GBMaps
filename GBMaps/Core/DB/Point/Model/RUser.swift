//
//  File.swift
//  GBMaps
//
//  Created by Илья Кадыров on 31.08.2021.
//

import Foundation
import RealmSwift

class RUser: Object {
    @objc dynamic var login: String? = nil
    @objc dynamic var password: String? = nil
    
    override static func primaryKey() -> String? {
        return "login"
      }
}
