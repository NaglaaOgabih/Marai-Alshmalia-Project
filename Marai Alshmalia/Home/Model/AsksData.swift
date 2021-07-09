//
//  AsksData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 27/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - AsksData
struct AsksData: Codable {
    let key, msg: String
    let data: [Ask]
}

// MARK: - Datum
struct Ask: Codable {
    let id: Int
    let ask, answer: String
    var isExpanded:Bool? = false
}
