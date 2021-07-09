//
//  PhoneNumData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 17/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - PhoneNumData
struct PhoneNumData: Codable {
    let key, msg: String
    let data: ForgetPassData
}

// MARK: - DataClass
struct ForgetPassData: Codable {
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
