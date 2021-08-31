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
    let userService = RUserService()
    let router = RegistrationRouter()
    
    @IBAction func registrationAction(_ sender: Any) {
       let resultSave = userService.save(login: loginView.text, password: passwordView.text)
        guard resultSave == nil else {
            router.showErrorAlert(text: resultSave!.rawValue)
            return
        }
        router.toMain()
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
