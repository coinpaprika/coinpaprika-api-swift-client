//
//  Market.swift
//  Pods
//
//  Created by Dominique Stranz on 08/11/2018.
//

import Foundation

/// Exchange Market
public struct Market: Equatable, CodableModel {
    
    /// Exchange pair, eg. ETH/BTC
    public let pair: String

    /// Base currency ID, eg. eth-ethereum
    public let baseCurrencyId: String
    
    /// Base currency name, eg. Ethereum
    public let baseCurrencyName: String
    
    /// Quote currency ID, eg. btc-bitcoin
    public let quoteCurrencyId: String
    
    /// Quote currency name, eg. Bitcoin
    public let quoteCurrencyName: String
    
    /// Market URL on `Exchange` website
    public let marketUrl: URL?
    
    /// Market category, eg. Spot
    public let category: Category
    
    /// Market fee type, eg. Percentage
    public let feeType: FeeType
    
    /// Outliner
    public let outlier: Bool
    
    /// Percent of volume
    public let reportedVolume24hShare: Decimal
    
    /// Last update time
    public let lastUpdated: Date
    
    private let quotes: [String: Quote]
    
    enum CodingKeys: String, CodingKey {
        case pair
        case baseCurrencyId = "base_currency_id"
        case baseCurrencyName = "base_currency_name"
        case quoteCurrencyId = "quote_currency_id"
        case quoteCurrencyName = "quote_currency_name"
        case marketUrl = "market_url"
        case category
        case feeType = "fee_type"
        case outlier
        case reportedVolume24hShare = "reported_volume_24h_share"
        case lastUpdated = "last_updated"
        case quotes
    }
    
    /// Use this method to access market data in provided quote currency
    ///
    /// - Parameter currency: QuoteCurrency, eg. .usd or .btc
    ///
    /// - For accessing coin price in USD use `market[.usd].price`
    /// - For accessing coin volume24h in BTC use `market[.btc].volume24h`
    /// - This method returns implicitly unwrapped optional `Quote!` - be sure to download Market(s) with requested `QuoteCurrency` before use
    public subscript(_ currency: QuoteCurrency) -> Quote! {
        assert(quotes[currency.code] != nil, "Invalid quote value \(currency). Check if you included \(currency) in request params.")
        return quotes[currency.code]
    }
    
    /// Market.Quote
    public struct Quote: Codable, Equatable {
        /// Price
        public let price: Decimal
        
        /// Volume from last 24h
        public let volume24h: Decimal
        
        enum CodingKeys: String, CodingKey {
            case price
            case volume24h = "volume_24h"
        }
    }

    /// Market category
    public enum Category: String, Codable {
        /// Spot
        case spot = "Spot"
        
        /// Derivatives
        case derivatives = "Derivatives"
        
        /// OTC
        case otc = "OTC"
        
        case empty = ""
    }
    
    /// Market fees type
    public enum FeeType: String, Codable {
        /// Percentage
        case percentage = "Percentage"
        
        /// No Fees
        case noFees = "No Fees"
        
        /// Transaction Mining
        case transactionMining = "Transaction Mining"
        
        /// Unknown
        case unknown = "Unknown"
        
        case empty = ""
    }
}
