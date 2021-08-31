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
    
    @IBOutlet weak var loginView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    
    override func viewDidAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "isLogin") {
            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            let mainController = mainStoryBoard.instantiateViewController(identifier: "mainId")
            self.present(mainController, animated: true)
        }
    }
    
    @IBAction func loginAction(_ sender: Any) {
        guard let login = loginView.text,
              let password = passwordView.text,
              login == Constants.login && password == Constants.password else {
                    return
                }
        UserDefaults.standard.set(true, forKey: "isLogin")
        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
        let mainController = mainStoryBoard.instantiateViewController(identifier: "mainId")
        UIApplication.shared.windows.first?.rootViewController = mainController
        

    }
    @IBAction func recoveryAction(_ sender: Any) {
        let authStoryBoard = UIStoryboard(name: "Auth", bundle: nil)
        let recoverController = authStoryBoard.instantiateViewController(identifier: "onRecover")
        self.navigationController?.pushViewController(recoverController, animated: true)
    }
    @IBAction func registrationAction(_ sender: Any) {
        let authStoryBoard = UIStoryboard(name: "Auth", bundle: nil)
        let recoverController = authStoryBoard.instantiateViewController(identifier: "regId")
        self.navigationController?.pushViewController(recoverController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }
    


}
