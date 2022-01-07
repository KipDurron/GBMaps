//
//  BaseCoordinator.swift
//  GBMaps
//
//  Created by Илья Кадыров on 06.01.2022.
//

import Foundation
import UIKit

class BaseCoordinator {
    
    var childCoordinators: [BaseCoordinator] = []
    let flowFactory = FlowFactory()
    
    func start() {}
    
    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where coordinator === element {
            return
        }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: BaseCoordinator?) {
        guard !childCoordinators.isEmpty,
              let coordinator = coordinator else {return}
        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
    func setAsRoot(_ controller: UIViewController) {
        if #available(iOS 13, *) {
            let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
            sceneDelegate?.window?.rootViewController = controller
        } else {
            UIApplication.shared.keyWindow?.rootViewController = controller
        }
    }
    
    func showError(_ viewController: UIViewController, text: String) {
        let alert = flowFactory.makeErrorFlow(text: text)
        viewController.present(alert, animated: true)
    }
    
    func showMessage(_ viewController: UIViewController, text: String) {
        let alert = flowFactory.makeMessageFlow(text: text)
        viewController.present(alert, animated: true)
    }
}
