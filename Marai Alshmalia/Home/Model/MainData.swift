//
//  File.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 18/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - MainData
struct MainData: Codable {
    let key, msg: String
    let data: EnterData
}

// MARK: - DataClass
struct EnterData: Codable {
    let unreadNotifications: Int
    let slider: [String]
    let sections: [Section]

    enum CodingKeys: String, CodingKey {
        case unreadNotifications = "unread_notifications"
        case slider, sections
    }
}

// MARK: - Section
struct Section: Codable {
    let sectionID: Int
    let sectionName: String
    let products: [Product]

    enum CodingKeys: String, CodingKey {
        case sectionID = "section_id"
        case sectionName = "section_name"
        case products
    }
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let name, sectionName: String
    let avgRate, countRate: Int
    let isFav, inCart: Bool
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
