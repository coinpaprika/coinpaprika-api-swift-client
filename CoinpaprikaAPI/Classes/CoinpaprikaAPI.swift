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
    
    /// Get ticker information for all coins
    ///
    /// - Parameter quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func tickers(quotes: [QuoteCurrency] = [.usd]) -> Request<[Ticker]> {
        return Request<[Ticker]>(baseUrl: apiBaseUrl, method: .get, path: "tickers", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Get ticker information for specific coin
    ///
    /// - Parameter id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func ticker(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<Ticker> {
        return Request<Ticker>(baseUrl: apiBaseUrl, method: .get, path: "tickers/\(id)", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Search results scope
    ///
    /// - currencies: Cryptocurrencies
    /// - exchanges: Crypto Exchanges
    /// - icos: ICOs
    /// - people: People from projects
    /// - tags: Tags
    public enum SearchCategory: String, CaseIterable {
        case currencies
        case exchanges
        case icos
        case people
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
        return Request<SearchResults>(baseUrl: apiBaseUrl, method: .get, path: "search", params: ["q": query, "c": categories.map({ $0.rawValue }).joined(separator: ","), "limit": "\(limit)"])
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
    public static func exchanges() -> Request<[Exchange]> {
        return Request<[Exchange]>(baseUrl: apiBaseUrl, method: .get, path: "exchanges", params: nil)
    }
    
    /// Exchange details
    ///
    /// - Parameters:
    ///   - id: exchange identifier, like binance
    /// - Returns: Request to perform
    public static func exchange(id: String) -> Request<Exchange> {
        return Request<Exchange>(baseUrl: apiBaseUrl, method: .get, path: "exchanges/\(id)", params: nil)
    }
    
    /// Exchange markets
    ///
    /// - Parameters:
    ///   - id: exchange identifier, like binance
    /// - Returns: Request to perform
    public static func exchangeMarkets(id: String) -> Request<[Market]> {
        return Request<[Market]>(baseUrl: apiBaseUrl, method: .get, path: "exchanges/\(id)/markets", params: nil)
    }
}
