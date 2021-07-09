//
//  FavData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 25/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - FavData
struct FavData: Codable {
    let key, msg: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let name, sectionName: String
    let avgRate, countRate: Int
    var isFav, inCart: Bool
    let minPrice: Int
    let image: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case sectionName = "section_name"
        case avgRate = "avg_rate"
        case countRate = "count_rate"
        case isFav = "is_fav"
        case inCart = "in_cart"
        case minPrice = "min_price"
        case image
    }
}
