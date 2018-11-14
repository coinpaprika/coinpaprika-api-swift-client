//
//  Market.swift
//  Pods
//
//  Created by Dominique Stranz on 08/11/2018.
//

import Foundation

/// Exchange Market
public struct Market: Codable, Equatable, CodableModel {
    
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
    public let reportedVolumeShare: Decimal
    
    /// Last update time
    public let lastUpdated: Date
    
    private let quotes: [String: Quote]
    
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
        let price: Decimal
        
        /// Volume from last 24h
        let volume24h: Decimal
    }

    /// Market category
    public enum Category: String, Codable {
        /// Spot
        case spot = "Spot"
        
        /// Derivatives
        case derivatives = "Derivatives"
        
        /// OTC
        case otc = "OTC"
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
    }
}
