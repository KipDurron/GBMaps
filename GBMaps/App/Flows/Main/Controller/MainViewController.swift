//
//  MainViewController.swift
//  GBMaps
//
//  Created by Илья Кадыров on 30.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    let router = MainRouter()

    @IBAction func toMapAction(_ sender: Any) {
        self.router.toMap()
       
    }
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        self.router.toLogout()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
