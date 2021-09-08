//
//  MainRouter.swift
//  GBMaps
//
//  Created by Илья Кадыров on 31.08.2021.
//

import UIKit

class MainRouter: BaseRouter {
    func toMap() {
        let controller = self.flowFactory.makeMapFlow()
        self.push(controller)
       }
    
    func toLogout() {
        let controller = self.flowFactory.makeLoginFlow()
        self.setAsRoot(UINavigationController(rootViewController: controller))
    }
}
