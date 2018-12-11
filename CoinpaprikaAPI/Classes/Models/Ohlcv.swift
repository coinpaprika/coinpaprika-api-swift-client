//
//  Ohlcv.swift
//  Pods
//
//  Created by Dominique Stranz on 16/11/2018.
//

import Foundation

/// Open/High/Low/Close values with volume and market_cap
public struct Ohlcv: Codable, Equatable, CodableModel {
    
    /// Session open date
    let timeOpen: Date
    
    /// Session close date
    let timeClose: Date
    
    /// Open price
    let open: Decimal
    
    /// Highest price
    let high: Decimal
    
    /// Lowest price
    let low: Decimal
    
    /// Close price
    let close: Decimal
    
    /// Coin volume
    let volume: Decimal
    
    /// Coin market capitalization
    let marketCap: Int64
    
    enum CodingKeys: String, CodingKey {
        case timeOpen = "time_open"
        case timeClose = "time_close"
        case open
        case high
        case low
        case close
        case volume
        case marketCap = "market_cap"
    }
}
