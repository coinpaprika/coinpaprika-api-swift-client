//
//  Ohlcv.swift
//  Pods
//
//  Created by Dominique Stranz on 16/11/2018.
//

import Foundation

/// Open/High/Low/Close values with volume and market_cap
public struct Ohlcv: Equatable, CodableModel {
    
    /// Session open date
    public let timeOpen: Date
    
    /// Session close date
    public let timeClose: Date
    
    /// Open price
    public let open: Decimal?
    
    /// Highest price
    public let high: Decimal?
    
    /// Lowest price
    public let low: Decimal?
    
    /// Close price
    public let close: Decimal?
    
    /// Coin volume
    public let volume: Decimal?
    
    /// Coin market capitalization
    public let marketCap: Decimal?
    
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
