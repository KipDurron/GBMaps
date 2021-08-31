//
//  LoginViewController.swift
//  GBMaps
//
//  Created by Илья Кадыров on 30.08.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    enum Constants {
            static let login = "1"
            static let password = "1"
        }
    
    var router = LoginRouter()
    
    @IBOutlet weak var loginView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isLogin") {
            self.router.toMain()
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let login = loginView.text,
              let password = passwordView.text,
              login == Constants.login && password == Constants.password else {
                    return
                }
        UserDefaults.standard.set(true, forKey: "isLogin")
        self.router.toMain()
    }
    @IBAction func recoveryAction(_ sender: Any) {
        self.router.toRecoveryPassword()
    }
    @IBAction func registrationAction(_ sender: Any) {
        self.router.toRegistration()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    


}
