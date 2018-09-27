//
//  GlobalStats.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

public struct GlobalStats: Decodable, Equatable {
    public let marketCapUsd: Int64
    public let volume24hUsd: Int64
    public let bitcoinDominancePercentage: Decimal
    public let cryptocurrenciesNumber: Int
    public let lastUpdated: Date?
    
    enum CodingKeys: String, CodingKey {
        case marketCapUsd, bitcoinDominancePercentage, cryptocurrenciesNumber, lastUpdated
        case volume24hUsd = "volume24HUsd"
    }    
}
