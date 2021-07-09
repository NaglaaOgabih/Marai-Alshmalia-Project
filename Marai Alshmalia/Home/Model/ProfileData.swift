//
//  ProfileData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 01/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - ProfileData
struct ProfileData: Codable {
    let key, msg: String?
    let data: ProfileDataClass?
}

// MARK: - DataClass
struct ProfileDataClass: Codable {
    let id: Int?
    let name, phone, email: String?
    let avatar: String?
    let token: String?
}
