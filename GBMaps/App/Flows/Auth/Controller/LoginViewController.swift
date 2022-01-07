//
//  LoginViewController.swift
//  GBMaps
//
//  Created by Илья Кадыров on 30.08.2021.
//

import UIKit
import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    
    enum Constants {
            static let login = "1"
            static let password = "1"
        }
    
    let bag = DisposeBag()
    
    let userService = RUserService()
    let loginViewModel = LoginViewModel()
    
    @IBOutlet weak var loginView: UITextField!
    @IBOutlet weak var passwordView: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var onMain: (()->Void)?
    var onRecover: (()->Void)?
    var onRegistration: (()->Void)?
    var onMessage: ((Bool, String)->Void)?
    
    @IBAction func loginAction(_ sender: Any) {
        let loginText = self.loginView.text
        let passwordText = self.passwordView.text
        self.loginViewModel.checkLoginAndPassword(login: loginText, password: passwordText)
    }
    
    @IBAction func recoveryAction(_ sender: Any) {
        onRecover?()
    }
    
    @IBAction func registrationAction(_ sender: Any) {
        onRegistration?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLoginSubscribe()
        configBindings()
    }
    
    func configBindings() {
        self.loginViewModel.resultCheckLoginAndPassword
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext:{[weak self]resultCheck in
            guard resultCheck == nil else {
                self?.onMessage?(true, resultCheck?.rawValue ?? "")
                return
            }
            UserDefaults.standard.set(true, forKey: "isLogin")
            self?.onMain?()
        }).disposed(by: bag)
    }
    
    func configLoginSubscribe() {
        Observable
// Объединяем два обсервера в один
            .combineLatest(
// Обсервер изменения текста
                loginView.rx.text,
// Обсервер изменения текста
                passwordView.rx.text
            )
// Модифицируем значения из двух обсерверов в один
            .map { login, password in
// Если введены логин и пароль, будет возвращено “истина”
                return !(login ?? "").isEmpty && !(password ?? "").isEmpty
            }
// Подписываемся на получение событий
            .subscribe { [weak loginButton] inputFilled in
// Если событие означает успех, активируем кнопку, иначе деактивируем
                loginButton?.isEnabled = inputFilled
            }.disposed(by: bag)
    }
    


}
