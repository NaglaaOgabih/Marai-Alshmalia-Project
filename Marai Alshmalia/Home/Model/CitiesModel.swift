//
//  CitiesModel.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 06/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - CitiesModel
struct CitiesModel: Codable {
    let key, msg: String
    let data: [CitiesDatum]?
}

// MARK: - Datum
struct CitiesDatum: Codable {
    let id: Int?
    let title: String?
}
