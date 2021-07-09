//
//  SignInData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 17/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
// MARK: - SignInData
struct SignInData: Codable {
    let key, msg: String
    let data: DataSignIn?
}

// MARK: - DataClass
struct DataSignIn: Codable {
    let id: Int?
    let type, name, phone, email: String?
    let avatar: String?
    let token: String?
}
