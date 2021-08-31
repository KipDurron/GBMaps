//
//  RegistrationRouter.swift
//  GBMaps
//
//  Created by Илья Кадыров on 31.08.2021.
//

import UIKit

class RegistrationRouter: BaseRouter {
    func toMain() {
        let controller = self.flowFactory.makeMainFlow()
        self.setAsRoot(UINavigationController(rootViewController: controller))
       }
    

}
