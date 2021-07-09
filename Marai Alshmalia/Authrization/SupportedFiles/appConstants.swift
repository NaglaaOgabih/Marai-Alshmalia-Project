//
//  appConstants.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 26/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
//import KeychainSwift
import SwiftKeychainWrapper
class AppConstant {
//    static var Token = KeychainSwift().get("token")
    static var Token = KeychainWrapper.standard.string(forKey: "token")
//    static var isLoggedin = KeychainSwift().getBool("isLoggedin")
    static var isLoggedIn = KeychainWrapper.standard.bool(forKey: "isLoggedIn")

}
