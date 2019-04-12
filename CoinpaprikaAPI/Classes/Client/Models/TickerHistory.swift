//
//  TickerHistory.swift
//  CoinpaprikaAPI
//
//  Created by Dominique Stranz on 09/11/2018.
//

import Foundation

/// Coin Ticker historical data
public struct TickerHistory: Equatable, CodableModel {
    
    /// Data save time
    public let timestamp: Date
    
    /// Coin price at `timestamp` date
    public let price: Decimal
    
    /// Coin volume 24 before `timestamp` date
    public let volume24h: Decimal
    
    /// Coin market capitalization at `timestamp` date
    public let marketCap: Decimal
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case price
        case volume24h = "volume_24h"
        case marketCap = "market_cap"
    }
}
