//
//  MainCoordinator.swift
//  GBMaps
//
//  Created by Илья Кадыров on 06.01.2022.
//

import Foundation
import UIKit

final class MainCoordinator: BaseCoordinator {
    
    var rootViewController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showMainModule()
    }
    
    private func showMainModule() {
        let mainViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(MainViewController.self)
        mainViewController.onMap = {[weak self] usseles in
            self?.showMapModule(usseles: usseles)
        }
        mainViewController.onLogout = {[weak self] in
            self?.onFinishFlow?()
        }
        let rootViewController = UINavigationController(rootViewController: mainViewController)
        setAsRoot(rootViewController)
        self.rootViewController = rootViewController
    }
    
    private func showMapModule(usseles: String) {
        let mapViewController = UIStoryboard(name: "Map", bundle: nil)
            .instantiateViewController(MapViewController.self)
        mapViewController.usselesExampleVariable = usseles
        rootViewController?.pushViewController(mapViewController, animated: true)
    }
}
