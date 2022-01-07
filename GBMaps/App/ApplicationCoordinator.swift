//
//  ApplicationCoordinator.swift
//  GBMaps
//
//  Created by Илья Кадыров on 06.01.2022.
//

import Foundation

class ApplicationCoordinator: BaseCoordinator {
    
    override func start() {
        if UserDefaults.standard.bool(forKey: "isLogin") {
            toMain()
        } else {
            toAuth()
        }
    }
    
    private func toAuth() {
        let authCoordinator = AuthCoordinator()
        authCoordinator.onFinishFlow = {[weak self, weak authCoordinator] in
            self?.removeDependency(authCoordinator)
            self?.start()
        }
        addDependency(authCoordinator)
        authCoordinator.start()
    }
    
    private func toMain() {
        let mainCoordinator = MainCoordinator()
        mainCoordinator.onFinishFlow = {[weak self, weak mainCoordinator] in
            self?.removeDependency(mainCoordinator)
            self?.start()
        }
        addDependency(mainCoordinator)
        mainCoordinator.start()
    }
    
    
}
