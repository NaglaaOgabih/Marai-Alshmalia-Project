//
//  SelectedItemData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 19/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
// MARK: - SelectedItemData
struct SelectedItemData: Codable {
    let key, msg: String
    let data: SelectedData?
}

// MARK: - DataClass
struct SelectedData: Codable {
    let id: Int?
    let name, desc: String
    let avgRate, countRate, mincedPrice: Int
    var isFav, inCart: Bool
    let image: String
    let images: [String]
    let sizes, cuts, heads, encapsulations: [Cut]?
    let charities: [Charity]?

    enum CodingKeys: String, CodingKey {
        case id, name, desc
        case avgRate = "avg_rate"
        case countRate = "count_rate"
        case mincedPrice = "minced_price"
        case isFav = "is_fav"
        case inCart = "in_cart"
        case image, images, sizes, cuts, heads, encapsulations, charities
    }
}

// MARK: - Charity
struct Charity: Codable {
    let id: Int
    let name: String
}

// MARK: - Cut
struct Cut: Codable {
    let id: Int?
    let name: String?
    let price: Int?
}
