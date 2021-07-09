//
//  DescData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 28/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - DescData
struct DescData: Codable {
    let key, msg: String
    let data: AboutData
}

// MARK: - DataClass
struct AboutData: Codable {
    let desc: String
}
