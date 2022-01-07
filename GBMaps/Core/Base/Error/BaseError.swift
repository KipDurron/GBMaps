//
//  BaseError.swift
//  GBMaps
//
//  Created by Илья Кадыров on 31.08.2021.
//

import Foundation

enum BaseError: String {
    case notExistUser = "User dont exist"
    case badPassword = "Bad password"
    case emptyLoginOrPassword = "Empty login or password"
    case userAlreidyExist = "User already exist"
}
