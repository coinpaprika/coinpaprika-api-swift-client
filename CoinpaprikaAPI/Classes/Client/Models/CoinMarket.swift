//
//  CoinMarket.swift
//  Pods
//
//  Created by Dominique Stranz on 14/11/2018.
//

import Foundation

/// Exchange Market
public struct CoinMarket: Equatable, CodableModel {
    
    /// Exchange id, eg. binance
    public let exchangeId: String
    
    /// Exchange name, eg. Binance
    public let exchangeName: String
    
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
    public let category: Market.Category
    
    /// Market fee type, eg. Percentage
    public let feeType: Market.FeeType
    
    /// Outliner
    public let outlier: Bool
    
    /// Percent of volume
    public let adjustedVolume24hShare: Decimal
    
    /// Last update time
    public let lastUpdated: Date
    
    private let quotes: [String: Market.Quote]
    
    enum CodingKeys: String, CodingKey {
        case exchangeId = "exchange_id"
        case exchangeName = "exchange_name"
        case pair
        case baseCurrencyId = "base_currency_id"
        case baseCurrencyName = "base_currency_name"
        case quoteCurrencyId = "quote_currency_id"
        case quoteCurrencyName = "quote_currency_name"
        case marketUrl = "market_url"
        case category
        case feeType = "fee_type"
        case outlier
        case adjustedVolume24hShare = "adjusted_volume_24h_share"
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
    public subscript(_ currency: QuoteCurrency) -> Market.Quote! {
        assert(quotes[currency.code] != nil, "Invalid quote value \(currency). Check if you included \(currency) in request params.")
        return quotes[currency.code]
    }
}
