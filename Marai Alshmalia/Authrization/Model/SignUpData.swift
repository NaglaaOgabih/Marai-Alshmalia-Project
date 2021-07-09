//
//  SignInData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 13/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
struct SignUpData: Codable {
    let key, msg: String
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
