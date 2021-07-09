//
//  AddToCart.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 07/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
// MARK: - AddToCartModel
struct AddToCartModel: Codable {
    let key, msg: String
    let data: AddToCartData?
}

// MARK: - DataClass
struct AddToCartData: Codable {
    let productName: String?
    let totalCart: Int?

    enum CodingKeys: String, CodingKey {
        case productName = "product_name"
        case totalCart = "total_cart"
    }
}
