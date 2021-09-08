//
//  LoginViewModel.swift
//  GBMaps
//
//  Created by Илья Кадыров on 02.09.2021.
//

import Foundation
import RxSwift
import RxCocoa

class LoginViewModel {
    
    let userService = RUserService()
    public let resultCheckLoginAndPassword: PublishSubject<BaseError?> = PublishSubject()
    
    func checkLoginAndPassword(login: String?, password: String?) {
        let result = self.userService.checkLoginAndPassword(login: login, password: password)
        self.resultCheckLoginAndPassword.onNext(result)
    }
    
}
