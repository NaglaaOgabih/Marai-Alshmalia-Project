//
//  activeCodeData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 17/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
struct ActiveCodeData: Codable {
    let key, msg: String
    let data: DataCode
}

// MARK: - DataClass
struct DataCode: Codable {
    let userID: Int
    let name, phone, email: String
    let avatar: String
    let token: String

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case name, phone, email, avatar, token
    }
}
