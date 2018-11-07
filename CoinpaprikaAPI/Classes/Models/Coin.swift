//
//  Coin.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

public struct Coin: Codable, Equatable, CodableModel {
    public let id: String
    public let name: String
    public let symbol: String
    public let rank: Int
    public let isNew: Bool
    public let isActive: Bool
}
