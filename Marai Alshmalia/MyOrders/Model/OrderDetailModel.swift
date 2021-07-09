//
//  OrderDetail.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 08/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//


import Foundation

// MARK: - OrderDetailModel
struct OrderDetailModel: Codable {
    let key, msg: String
    let data: OrderDetailData
}

// MARK: - DataClass
struct OrderDetailData: Codable {
    let orderData: OrderDataNew?
    let productsData: [ProductsDatum]

    enum CodingKeys: String, CodingKey {
        case orderData = "order_data"
        case productsData = "products_data"
    }
}

// MARK: - OrderData
struct OrderDataNew: Codable {
    let orderID: Int
    let orderNum: String
    let orderTotal: Int
    let deliveryDate, notes, payType, payStatus: String
    let hasTransfer: Bool
    let payTypeName, orderStatus, orderStatusName: String

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderNum = "order_num"
        case orderTotal = "order_total"
        case deliveryDate = "delivery_date"
        case notes
        case payType = "pay_type"
        case payStatus = "pay_status"
        case hasTransfer = "has_transfer"
        case payTypeName = "pay_type_name"
        case orderStatus = "order_status"
        case orderStatusName = "order_status_name"
    }
}

// MARK: - ProductsDatum
struct ProductsDatum: Codable {
    let id, productID: Int
    let productName: String
    let productImage: String
    let sizeName: String
    let productQuantity, productTotal: Int

    enum CodingKeys: String, CodingKey {
        case id
        case productID = "product_id"
        case productName = "product_name"
        case productImage = "product_image"
        case sizeName = "size_name"
        case productQuantity = "product_quantity"
        case productTotal = "product_total"
    }
}
