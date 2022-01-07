////
////  LoginRouter.swift
////  GBMaps
////
////  Created by Илья Кадыров on 31.08.2021.
////
//
//import UIKit
//
//class LoginRouter: BaseRouter {
//    func toMain() {
//        let controller = self.flowFactory.makeMainFlow()
//        self.setAsRoot(UINavigationController(rootViewController: controller))
//       }
//    
//    func toRecoveryPassword() {
//        let controller = self.flowFactory.makeRecoveryPasswordFlow()
//        self.push(controller)
//    }
//    
//    func toRegistration() {
//        let controller = self.flowFactory.makeRegistrationFlow()
//        self.push(controller)
//    }
//}
