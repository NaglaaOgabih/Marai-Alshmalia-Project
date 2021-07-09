//
//  IntroData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 06/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let key, msg: String?
    let data: [introData]
}

// MARK: - Datum
struct introData: Codable {
    let image: String?
    let desc: String?
}
