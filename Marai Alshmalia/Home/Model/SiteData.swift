//
//  SiteData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 01/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - SiteData
struct SiteData: Codable {
    let key, msg: String
    let data: SiteDataClass
}

// MARK: - DataClass
struct SiteDataClass: Codable {
    let basicData: BasicData
    let socialData: SocialData
    let adminBanks: [AdminBank]
}

// MARK: - AdminBank
struct AdminBank: Codable {
    let bankName, accountNum: String

    enum CodingKeys: String, CodingKey {
        case bankName = "bank_name"
        case accountNum = "account_num"
    }
}

// MARK: - BasicData
struct BasicData: Codable {
    let email, phone, whatsapp: String
}

// MARK: - SocialData
struct SocialData: Codable {
    let facebook, twitter, instagram: String
}
