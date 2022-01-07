//
//  MainViewController.swift
//  GBMaps
//
//  Created by Илья Кадыров on 30.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    
    var onMap: ((String) -> Void)?
    var onLogout: (() -> Void)?
    
    

    @IBAction func toMapAction(_ sender: Any) {
        onMap?("Пример")
       
    }
    @IBAction func logoutAction(_ sender: Any) {
        UserDefaults.standard.set(false, forKey: "isLogin")
        onLogout?()
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }


}
