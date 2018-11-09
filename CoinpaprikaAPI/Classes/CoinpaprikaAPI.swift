//
//  Coinpaprika.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

/// Coinpaprika API endpoints
public struct CoinpaprikaAPI {
    
    private static let apiBaseUrl = URL(string: "https://api.coinpaprika.com/v1/")!
    
    /// Get global information
    ///
    /// - Returns: Request to perform
    public static func global() -> Request<GlobalStats> {
        return Request<GlobalStats>(baseUrl: apiBaseUrl, method: .get, path: "global", params: nil)
    }
    
    /// Get all coins listed on coinpaprika
    ///
    /// - Returns: Request to perform
    public static func coins() -> Request<[Coin]> {
        return Request<[Coin]>(baseUrl: apiBaseUrl, method: .get, path: "coins", params: nil)
    }
    
    private static func validateTickerQuotes(_ quotes: [QuoteCurrency]) {
        let acceptedQuotes: [QuoteCurrency] = [.usd, .btc, .eth]
        assert(quotes.filter({ !acceptedQuotes.contains($0) }).isEmpty, "This endpoint accepts only \(acceptedQuotes).")
    }
    
    /// Get ticker information for all coins
    ///
    /// - Parameter quotes: list of requested quotes, default [.usd], accepted values .usd, .btc, .eth
    /// - Returns: Request to perform
    public static func tickers(quotes: [QuoteCurrency] = [.usd]) -> Request<[Ticker]> {
        validateTickerQuotes(quotes)
        return Request<[Ticker]>(baseUrl: apiBaseUrl, method: .get, path: "tickers", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Get ticker information for specific coin
    ///
    /// - Parameter id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func ticker(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<Ticker> {
        validateTickerQuotes(quotes)
        return Request<Ticker>(baseUrl: apiBaseUrl, method: .get, path: "tickers/\(id)", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Search results scope
    public enum SearchCategory: String, CaseIterable, QueryRepresentable {
        /// Cryptocurrencies
        case currencies
        
        /// Crypto Exchanges
        case exchanges
        
        /// ICOs
        case icos
        
        /// People from projects
        case people
        
        /// Tags
        case tags
    }
    
    /// Search for currencies/icos/people/exchanges/tags
    ///
    /// - Parameters:
    ///   - query: phrase for search eg. btc
    ///   - categories: one or more categories (comma separated) to search, default .allCases - see SearchCategory for available options
    ///   - limit: limit of results per category, default 6 (max 250)
    /// - Returns: Request to perform
    public static func search(query: String, categories: [SearchCategory] = SearchCategory.allCases, limit: UInt = 6) -> Request<SearchResults> {
        return Request<SearchResults>(baseUrl: apiBaseUrl, method: .get, path: "search", params: ["q": query, "c": categories.asCommaJoinedList, "limit": "\(limit)"])
    }
    
    /// Additional fields available in Tag response
    ///
    /// - coins: add this field if you want to match Coins with Tags
    public enum TagsAdditionalFields: String, CaseIterable, QueryRepresentable {
        case coins
    }

    /// Tags lists
    ///
    /// - Parameter additionalFields: list of additional fields that should be included in response, default: empty - see TagsAdditionalFields for available options
    /// - Returns: Request to perform
    public static func tags(additionalFields: [TagsAdditionalFields] = []) -> Request<[Tag]> {
        return Request<[Tag]>(baseUrl: apiBaseUrl, method: .get, path: "tags", params: ["additional_fields": additionalFields.asCommaJoinedList])
    }
    
    /// Tag details
    ///
    /// - Parameters:
    ///   - id: tag identifier, like erc20
    ///   - additionalFields: list of additional fields that should be included in response, default: empty - see TagsAdditionalFields for available options
    /// - Returns: Request to perform
    public static func tag(id: String, additionalFields: [TagsAdditionalFields] = []) -> Request<Tag> {
        return Request<Tag>(baseUrl: apiBaseUrl, method: .get, path: "tags/\(id)", params: ["additional_fields": additionalFields.asCommaJoinedList])
    }
    
    /// Exchanges list
    ///
    /// - Returns: Request to perform
    public static func exchanges(quotes: [QuoteCurrency] = [.usd]) -> Request<[Exchange]> {
        return Request<[Exchange]>(baseUrl: apiBaseUrl, method: .get, path: "exchanges", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Exchange details
    ///
    /// - Parameters:
    ///   - id: exchange identifier, like binance
    ///   - quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func exchange(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<Exchange> {
        return Request<Exchange>(baseUrl: apiBaseUrl, method: .get, path: "exchanges/\(id)", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Exchange markets
    ///
    /// - Parameters:
    ///   - id: exchange identifier, like binance
    /// - Returns: Request to perform
    public static func exchangeMarkets(id: String) -> Request<[Market]> {
        return Request<[Market]>(baseUrl: apiBaseUrl, method: .get, path: "exchanges/\(id)/markets", params: nil)
    }
    
    private static func validateTickerHistoryQuote(_ quote: QuoteCurrency) {
        let acceptedQuotes: [QuoteCurrency] = [.usd, .btc]
        assert(acceptedQuotes.contains(quote), "This endpoint accepts only \(acceptedQuotes).")
    }
    
    private static func validateTickerHistoryLimit(_ limit: Int) {
        let min = 1
        let max = 5000
        assert(min >= 0 && max <= 5000, "Limit should be between \(min) and \(max).")
    }
    
    /// Intervals for historical data endpoint
    public enum TickerHistoryInterval: String, CaseIterable {
        /// 5 minutes interval
        case minutes5 = "5m"
        
        /// 10 minutes interval
        case minutes10 = "10m"
        
        /// 15 minutes interval
        case minutes15 = "15m"
        
        /// 30 minutes interval
        case minutes30 = "30m"
        
        /// 45 minutes interval
        case minutes45 = "45m"
        
        /// 1 hour interval
        case hours1 = "1h"
        
        /// 2 hours interval
        case hours2 = "2h"
        
        /// 3 hours interval
        case hours3 = "3h"
        
        /// 6 hours interval
        case hours6 = "6h"
        
        /// 12 hours interval
        case hours12 = "12h"
        
        /// 24 hours interval
        case hours24 = "24h"
        
        /// 1 day interval
        case days1 = "1d"
        
        /// 7 days interval
        case days7 = "7d"
        
        /// 14 days interval
        case days14 = "14d"
        
        /// 30 days interval
        case days30 = "30d"
        
        /// 90 days interval
        case days90 = "90d"
        
        /// 365 days interval
        case days365 = "365d"
    }
    
    
    /// Get historical ticker information for specific coin
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    ///   - start: Start date, required
    ///   - end: End date, default .now
    ///   - limit: Returns limit, default 1000, max 5000
    ///   - quote: requested quote, default .usd
    ///   - interval: data interval, default 5 minutes .minutes5
    /// - Returns: Request to perform
    public static func tickerHistory(id: String, start: Date, end: Date = Date(), limit: Int = 1000, quote: QuoteCurrency = .usd, interval: TickerHistoryInterval = .minutes5) -> Request<[TickerHistory]> {
        validateTickerHistoryQuote(quote)
        validateTickerHistoryLimit(limit)
        return Request<[TickerHistory]>(baseUrl: apiBaseUrl, method: .get, path: "tickers/historical/\(id)", params: ["start": "\(Int(start.timeIntervalSince1970))", "end": "\(Int(end.timeIntervalSince1970))", "limit": "\(limit)", "quote": quote.rawValue, "interval": interval.rawValue])
    }

}
