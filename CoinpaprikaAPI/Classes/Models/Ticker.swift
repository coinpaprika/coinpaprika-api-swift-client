//
//  Ticker.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 05.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

/// Coin Ticker
public struct Ticker: Codable, Equatable, CodableModel {
    
    /// Coin id, eg. btc-bitcoin
    public let id: String
    
    /// Coin name, eg. Bitcoin
    public let name: String
    
    /// Coin symbol, eg. BTC
    public let symbol: String
    
    /// Coin position in Coinpaprika ranking
    public let rank: Int
    
    /// Coins circulating on the market
    public let circulatingSupply: Int64
    
    /// Total number of coins
    public let totalSupply: Int64
    
    /// Maximum number of coins that could exist
    public let maxSupply: Int64
    
    /// Circulating Supply / Max Supply Rate
    public var circulatingSupplyPercent: Decimal? {
        guard maxSupply != 0 else {
            return nil
        }
        
        return Decimal(circulatingSupply)/Decimal(maxSupply)
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
        public let volume24h: Int64
        
        /// Volume change in last 24h
        public let volume24hChange24h: Decimal
        
        /// Market Capitalization
        public let marketCap: Int64
        
        /// Market Capitalization in last 24h
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
            
            return Decimal(volume24h)/Decimal(marketCap)
        }
    }
}
