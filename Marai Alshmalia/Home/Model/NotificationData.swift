//
//  NotificationData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 31/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation

// MARK: - NotificationData
struct NotificationData: Codable {
    let key, msg: String
    let data: NFdata
}

// MARK: - DataClass
struct NFdata: Codable {
    let data: [Datumm]
    let pagination: Pagination
}

// MARK: - Datum
struct Datumm: Codable {
    let id, userID: Int
    let message: Message
    let seen: Int
    let createdAt: CreatedAt

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case message, seen
        case createdAt = "created_at"
    }
}

enum CreatedAt: String, Codable {
    case ساعةمنالآن = "ساعة من الآن"
}

enum Message: String, Codable {
    case notificationMessageAr = "notification message ar"
}

// MARK: - Pagination
struct Pagination: Codable {
    let total, count, perPage, currentPage: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case total, count
        case perPage = "per_page"
        case currentPage = "current_page"
        case totalPages = "total_pages"
    }
}
