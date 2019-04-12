//
//  Exchange.swift
//  Pods
//
//  Created by Dominique Stranz on 27/09/2018.
//

import Foundation

/// Exchange
public struct Exchange: Equatable, CodableModel {
    /// Exchange id, eg. binance
    public let id: String
    
    /// Exchange name, eg. Binance
    public let name: String
    
    /// Exchange description
    public let description: String
    
    /// Is this exchange active
    public let active: Bool
    
    /// Exchange website status
    public let websiteStatus: Bool
    
    /// Exchange API status
    public let apiStatus: Bool
    
    /// Reason why it's not active
    public let message: String?
    
    /// Exchange links
    public let links: Links?
    
    /// Is market data fetched
    public let marketsDataFetched: Bool
    
    /// Position in ranking based on adjusted volume
    public let adjustedRank: Int?
    
    /// Position in ranking based on reported volume
    public let reportedRank: Int?
    
    /// Supported currencies
    public let currencies: Int
    
    /// Supported markets
    public let markets: Int
    
    /// List of supported fiat currencies
    public let fiats: [Fiat]
    
    /// Last update time
    public let lastUpdated: Date
    
    private let quotes: [String: Quote]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case active
        case websiteStatus = "website_status"
        case apiStatus = "api_status"
        case message
        case links
        case marketsDataFetched = "markets_data_fetched"
        case adjustedRank = "adjusted_rank"
        case reportedRank = "reported_rank"
        case currencies
        case markets
        case fiats
        case lastUpdated = "last_updated"
        case quotes
    }
    
    /// Use this method to access exchange data in provided quote currency
    ///
    /// - Parameter currency: QuoteCurrency, eg. .usd or .btc
    ///
    /// - For accessing reported volume in USD use `exchange[.usd].reportedVolume24h`
    /// - For accessing adjusted volume in BTC use `exchange[.btc].adjustedVolume24h`
    /// - This method returns implicitly unwrapped optional `Quote!` - be sure to download Exchange(s) with requested `QuoteCurrency` before use
    public subscript(_ currency: QuoteCurrency) -> Quote! {
        assert(quotes[currency.code] != nil, "Invalid quote value \(currency). Check if you included \(currency) in request params.")
        return quotes[currency.code]
    }
    
    /// Exchange.Quote data
    public struct Quote: Codable, Equatable {
        /// Exchange reported volume from last 24h
        public let reportedVolume24h: Decimal
        
        /// Exchange adjusted volume from last 24h
        public let adjustedVolume24h: Decimal
        
        enum CodingKeys: String, CodingKey {
            case reportedVolume24h = "reported_volume_24h"
            case adjustedVolume24h = "adjusted_volume_24h"
        }
    }
    
    /// Exchange.Links
    public struct Links: Codable, Equatable {
        /// Collection of Twitter profiles URLs
        public let twitter: [URL]?
        
        /// Collection of websites URLs
        public let website: [URL]?
        
        /// Collection of blogs URLs
        public let blog: [URL]?
        
        /// Collection of chat URLs
        public let chat: [URL]?
        
        /// Collection of fees information URLs
        public let fees: [URL]?
        
        /// Collection of Telegram URLs
        public let telegram: [URL]?
    }
    
    /// Exchange.Fiat
    public struct Fiat: Codable, Equatable {
        
        /// Fiat name, eg. US Dollars
        public let name: String
        
        /// Fiat symbol, eg. USD
        public let symbol: String
    }
}
