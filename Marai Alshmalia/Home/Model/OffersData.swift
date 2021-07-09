//
//  OffersData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 26/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
// MARK: - OffersData
struct OffersData: Codable {
    let key, msg: String
    let data: [Offers]
}

// MARK: - Datum
struct Offers: Codable {
    let image: String
    let productID: Int

    enum CodingKeys: String, CodingKey {
        case image
        case productID = "product_id"
    }
}
