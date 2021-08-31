//
//  LaunchViewController.swift
//  GBMaps
//
//  Created by Илья Кадыров on 30.08.2021.
//

import UIKit

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if UserDefaults.standard.bool(forKey: "isLogin") {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let mainController = mainStoryBoard.instantiateViewController(identifier: "navMainId")
            UIApplication.shared.windows.first?.rootViewController = mainController

        } else {
            let mainStoryBoard = UIStoryboard(name: "Auth", bundle: nil)
            let authController = mainStoryBoard.instantiateViewController(identifier: "navAuthId")
            UIApplication.shared.windows.first?.rootViewController = authController
        }
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    

}
