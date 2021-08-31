//
//  MainViewController.swift
//  GBMaps
//
//  Created by Илья Кадыров on 30.08.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func toMapAction(_ sender: Any) {
        let mapStoryBoard = UIStoryboard(name: "Map", bundle: nil)
        let mapController = mapStoryBoard.instantiateViewController(identifier: "mapId")
        self.navigationController?.pushViewController(mapController, animated: true)
       
    }
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        let mainStoryBoard = UIStoryboard(name: "Auth", bundle: nil)
        let authController = mainStoryBoard.instantiateViewController(identifier: "authId")
        UIApplication.shared.windows.first?.rootViewController = authController
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
