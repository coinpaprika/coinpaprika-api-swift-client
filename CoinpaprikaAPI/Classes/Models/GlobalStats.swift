//
//  GlobalStats.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

public struct GlobalStats: Codable, Equatable, CodableModel {
    public let marketCapUsd: Int64
    public let volume24hUsd: Int64
    public let bitcoinDominancePercentage: Decimal
    public let cryptocurrenciesNumber: Int
    public let lastUpdated: Date
    
    public static var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? {
        return .secondsSince1970
    }
    
    public static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? {
        return .secondsSince1970
    }
}
