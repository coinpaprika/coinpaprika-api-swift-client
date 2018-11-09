//
//  TickerHistory.swift
//  CoinpaprikaAPI
//
//  Created by Dominique Stranz on 09/11/2018.
//

import Foundation

/// Coin Ticker historical data
public struct TickerHistory: Codable, Equatable, CodableModel {
    
    /// Data save time
    let timestamp: Date
    
    /// Coin Price at `timestamp` date
    let price: Decimal
    
    /// Coin Volume 24 before `timestamp` date
    let volume24h: Decimal
    
    /// Coin Market Capitalization at `timestamp` date
    let marketCap: Decimal
}
