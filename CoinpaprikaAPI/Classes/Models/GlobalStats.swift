//
//  GlobalStats.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

/// Global market data
public struct GlobalStats: Codable, Equatable, CodableModel {
    
    /// Market capitalization in USD
    public let marketCapUsd: Int64
    
    /// Volume from last 24h
    public let volume24hUsd: Int64
    
    /// Bitcoin share in whole market capitalization
    public let bitcoinDominancePercentage: Decimal
    
    /// Number of cryptocurrencies
    public let cryptocurrenciesNumber: Int
    
    /// Last update time
    public let lastUpdated: Date
    
    public static var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? {
        return .secondsSince1970
    }
    
    public static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? {
        return .secondsSince1970
    }
}
