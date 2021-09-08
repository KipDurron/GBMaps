//
//  RecoveryPasswordViewController.swift
//  GBMaps
//
//  Created by Илья Кадыров on 30.08.2021.
//

import UIKit

class RecoveryPasswordViewController: UIViewController {

    @IBOutlet weak var loginView: UITextField!
    @IBAction func recoveryAction(_ sender: Any) {
        guard let login = loginView.text,
              login == LoginViewController.Constants.login else {
            return
        }
                showPassword()
    }
    
    private func showPassword() {
        let alert = UIAlertController(title: "Пароль", message: "123456", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    



}
