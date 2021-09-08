//
//  RUserService.swift
//  ForVK
//
//  Created by Илья Кадыров on 11.10.2020.
//  Copyright © 2020 Илья Ишунин. All rights reserved.
//

import Foundation
import RealmSwift

class RUserService {
    
    let realmSetting = RealmSetting()
    let realm: Realm
    
    init() {
        realm = realmSetting.getRealm()
    }
    
    func save(login: String?, password: String?) -> BaseError? {
        guard let login = login,
              let password = password,
              !login.isEmpty,
              !password.isEmpty else {
            return BaseError.emptyLoginOrPassword
        }
        do {
            if !self.checkExist(login: login) {
                let rUser =  RUser()
                rUser.login = login
                rUser.password = password
                realm.beginWrite()
                realm.add(rUser)
                try realm.commitWrite()
            }
        } catch {
            debugPrint(error)
        }
        return nil
    }
    
    func checkExist(login: String) -> Bool{
        if self.getByLogin(login: login) != nil {
            return true
        } else {
            return false
        }
    }
    
    func getByLogin(login: String) -> RUser? {
        return realm.objects(RUser.self).filter("login == %@", login).first
    }
    
    func checkLoginAndPassword(login: String?, password: String?) -> BaseError? {
        guard let login = login,
              let password = password,
              !login.isEmpty,
              !password.isEmpty else {
            return BaseError.emptyLoginOrPassword
        }
        guard let user = self.getByLogin(login: login) else {
            return BaseError.notExistUser
        }
        guard user.password == password else {
            return BaseError.badPassword
        }
        return nil
    }
    
//    func load() -> [RUser] {
//        return realm.objects(RUser.self).map{User(rUser: $0)}
//    }
    
    func loadResult() -> Results<RUser> {
        return realm.objects(RUser.self)
    }
    
}

