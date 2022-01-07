////
////  BaseRouter.swift
////  GBMaps
////
////  Created by Илья Кадыров on 31.08.2021.
////
//
//import UIKit
//
//class BaseRouter: NSObject {
//    
//    private weak var controller: UIViewController?
//    let flowFactory = FlowFactory()
//    
//    func show(_ controller: UIViewController) {
//        self.controller?.show(controller, sender: nil)
//    }
//    
//    func present(_ controller: UIViewController) {
//        self.controller?.present(controller, animated: true)
//    }
//    
//    func setAsRoot(_ controller: UIViewController) {
//        UIApplication.shared.windows.first?.rootViewController = controller
//    }
//    
//    func push(_ controller: UIViewController) {
//        self.controller?.navigationController?.pushViewController(controller, animated: true)
//    }
//    
//    func setController(_ controller: UIViewController) {
//        self.controller = controller
//    }
//    
//    func showMessageAlert(text: String) {
//        let controller = self.flowFactory.makeMessageFlow(text: text)
//        self.present(controller)
//    }
//    
//    func showErrorAlert(text: String) {
//        let controller = self.flowFactory.makeErrorFlow(text: text)
//        self.present(controller)
//    }
//    
//}
