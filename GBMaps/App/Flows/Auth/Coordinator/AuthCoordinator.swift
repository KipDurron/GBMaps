//
//  AuthCoordinator.swift
//  GBMaps
//
//  Created by Илья Кадыров on 06.01.2022.
//

import Foundation
import UIKit

class AuthCoordinator: BaseCoordinator {
    var rootViewController: UINavigationController?
    var onFinishFlow: (() -> Void)?
    
    override func start() {
        showAuthModule()
    }
    
    private func showAuthModule() {
        let loginViewController = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(LoginViewController.self)
        loginViewController.onRecover = {[weak self] in
            self?.showRecoverModule()
        }
        
        loginViewController.onRegistration = {[weak self] in
            self?.showRegistrationModule()
        }
        
        loginViewController.onMessage = { [weak self, weak loginViewController] (isError, text) in
            guard let loginViewController = loginViewController else {return}
            if isError {
                self?.showError(loginViewController, text: text)
            } else {
                self?.showMessage(loginViewController, text: text)
            }
        }
        
        loginViewController.onMain = {[weak self] in
            self?.onFinishFlow?()
        }
        let rootViewController = UINavigationController(rootViewController: loginViewController)
        setAsRoot(rootViewController)
        self.rootViewController = rootViewController
    }
    
    private func showRecoverModule() {
        let recoverViewController = UIStoryboard(name: "Auth", bundle: nil).instantiateViewController(RecoveryPasswordViewController.self)
        rootViewController?.pushViewController(recoverViewController, animated: true)
    }
    
    private func showRegistrationModule() {
        let registrationViewController = UIStoryboard(name: "Auth", bundle: nil)
            .instantiateViewController(RegistrationViewController.self)
        rootViewController?.pushViewController(registrationViewController, animated: true)
        
        registrationViewController.onMain = {[weak self] in
            self?.onFinishFlow?()
        }
        registrationViewController.onMessage  = { [weak self, weak registrationViewController] (isError, text) in
            guard let registrationViewController = registrationViewController else {return}
            if isError {
                self?.showError(registrationViewController, text: text)
            } else {
                self?.showMessage(registrationViewController, text: text)
            }
        }
    }
}
