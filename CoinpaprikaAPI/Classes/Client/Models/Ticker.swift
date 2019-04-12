//
//  Ticker.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 05.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

/// Coin Ticker
public struct Ticker: Equatable, CodableModel {
    
    /// Coin id, eg. btc-bitcoin
    public let id: String
    
    /// Coin name, eg. Bitcoin
    public let name: String
    
    /// Coin symbol, eg. BTC
    public let symbol: String
    
    /// Coin position in Coinpaprika ranking
    public let rank: Int
    
    /// Coins circulating on the market
    public let circulatingSupply: Decimal
    
    /// Total number of coins
    public let totalSupply: Decimal
    
    /// Maximum number of coins that could exist
    public let maxSupply: Decimal
    
    /// Circulating Supply / Max Supply Rate
    public var circulatingSupplyPercent: Decimal? {
        guard maxSupply != 0 else {
            return nil
        }
        
        return circulatingSupply/maxSupply
    }
    
    /// Beta (β or beta coefficient) of an investment indicates whether the investment is more or less volatile than the market as a whole.
    /// - β < 0 Asset movement is in the opposite direction of the total crypto market
    /// - β = 0 Asset movement is uncorrelated to the total crypto market
    /// - 0 < β < 1 Asset moves in the same direction, but in a lesser amount than the total crypto market
    /// - β = 1 Asset moves in the same direction and in the same amount as the total crypto market
    /// - β > 1 Asset moves in the same direction, but in a greater amount than the total crypto market
    public let betaValue: Decimal
    
    /// Last update time
    public let lastUpdated: Date
    
    private let quotes: [String: Quote]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case rank
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case betaValue = "beta_value"
        case lastUpdated = "last_updated"
        case quotes
    }
    
    /// Use this method to access coin market data in provided quote currency
    ///
    /// - Parameter currency: QuoteCurrency, eg. .usd or .btc
    ///
    /// - For accessing coin price in USD use `ticker[.usd].price`
    /// - For accessing coin volume24h in BTC use `ticker[.btc].volume24h`
    /// - This method returns implicitly unwrapped optional `Quote!` - be sure to download Ticker(s) with requested `QuoteCurrency` before use
    public subscript(_ currency: QuoteCurrency) -> Quote! {
        assert(quotes[currency.code] != nil, "Invalid quote value \(currency). Check if you included \(currency) in request params.")
        return quotes[currency.code]
    }
    
    /// Coin market data
    public struct Quote: Codable, Equatable {
        
        /// Price
        public let price: Decimal
        
        /// Volume from last 24h
        public let volume24h: Decimal
        
        /// Volume change in last 24h
        public let volume24hChange24h: Decimal
        
        /// Market capitalization
        public let marketCap: Decimal
        
        /// Market capitalization change in last 24h
        public let marketCapChange24h: Decimal
        
        /// Percentage price change in last 1 hour
        public let percentChange1h: Decimal
        
        /// Percentage price change in last 12 hours
        public let percentChange12h: Decimal
        
        /// Percentage price change in last 24 hours
        public let percentChange24h: Decimal
        
        /// Percentage price change in last 7 days
        public let percentChange7d: Decimal
        
        /// Percentage price change in last 30 days
        public let percentChange30d: Decimal
        
        /// Percentage price change in last 1 yours
        public let percentChange1y: Decimal
        
        /// ATH (All Time High) price
        public let athPrice: Decimal?
        
        /// ATH (All Time High) date
        public let athDate: Date?
        
        /// Percentage price change from ATH
        public let percentFromPriceAth: Decimal?
        
        /// Volume / MarketCap rate
        public var volumeMarketCapRate: Decimal? {
            guard marketCap != 0 else {
                return nil
            }
            
            return volume24h/marketCap * 100
        }
        
        enum CodingKeys: String, CodingKey {
            case price
            case volume24h = "volume_24h"
            case volume24hChange24h = "volume_24h_change_24h"
            case marketCap = "market_cap"
            case marketCapChange24h = "market_cap_change_24h"
            case percentChange1h = "percent_change_1h"
            case percentChange12h = "percent_change_12h"
            case percentChange24h = "percent_change_24h"
            case percentChange7d = "percent_change_7d"
            case percentChange30d = "percent_change_30d"
            case percentChange1y = "percent_change_1y"
            case athPrice = "ath_price"
            case athDate = "ath_date"
            case percentFromPriceAth = "percent_from_price_ath"
        }
    }
}
