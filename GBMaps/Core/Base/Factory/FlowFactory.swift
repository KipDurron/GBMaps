//
//  ModuleFactory.swift
//  GBShop
//
//  Created by Илья Кадыров on 13.07.2021.
//
import UIKit

class FlowFactory {
//    func makeMainFlow() -> MainViewController {
//        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(MainViewController.self)
//        controller.router.setController(controller)
//        return controller
//    }
//    
//    func makeLoginFlow() -> LoginViewController {
//        let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(LoginViewController.self)
//        controller.router.setController(controller)
//        return controller
//    }
//    
//    func makeRecoveryPasswordFlow() -> RecoveryPasswordViewController {
//        let controller = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(RecoveryPasswordViewController.self)
//        return controller
//    }
//    
//    func makeRegistrationFlow() -> RegistrationViewController {
//        let controller = UIStoryboard(name: "Auth", bundle: nil)
//            .instantiateViewController(RegistrationViewController.self)
//        controller.router.setController(controller)
//        return controller
//    }
//    
//    func makeMapFlow() -> MapViewController {
//        let controller = UIStoryboard(name: "Map", bundle: nil)
//            .instantiateViewController(MapViewController.self)
//        return controller
//    }
//
    func makeErrorFlow(text: String) -> UIAlertController {
        let alert = UIAlertController(title: "🤬 Error", message: text, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        return alert
    }

    func makeMessageFlow(text: String) -> UIAlertController {
        let alert = UIAlertController(title: "💕 Message", message: text, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        return alert
    }

}
