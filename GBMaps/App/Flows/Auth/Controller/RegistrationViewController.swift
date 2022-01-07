//
//  RegistrationViewController.swift
//  GBMaps
//
//  Created by Илья Кадыров on 30.08.2021.
//

import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var loginView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    
    var onMessage: ((Bool, String)->Void)?
    var onMain: (()->Void)?
    
    let userService = RUserService()
    
    @IBAction func registrationAction(_ sender: Any) {
       let resultSave = userService.save(login: loginView.text, password: passwordView.text)
        guard resultSave == nil else {
            onMessage?(true, resultSave?.rawValue ?? "")
            return
        }
        UserDefaults.standard.set(true, forKey: "isLogin")
        onMain?()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}
