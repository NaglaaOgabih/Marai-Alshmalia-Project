//
//  needActiveModel.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 17/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - NeedActiveModel
struct NeedActiveModel: Codable {
    let key, msg: String
    let data: ActiveData?
}

// MARK: - DataClass
struct ActiveData: Codable {
    let userID: Int

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
    }
}
