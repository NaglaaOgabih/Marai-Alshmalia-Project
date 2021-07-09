//
//  WalletBalanceData.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 27/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
// MARK: - WalletBalanceData
struct WalletBalanceData: Codable {
    let key, msg: String
    let data: Balance
}

// MARK: - DataClass
struct Balance: Codable {
    let balance: Double
}
