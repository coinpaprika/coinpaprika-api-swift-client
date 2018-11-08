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
    public static var global: Request<GlobalStats> {
        return Request<GlobalStats>(baseUrl: apiBaseUrl, method: .get, path: "global", params: nil)
    }
    
    /// Get all coins listed on coinpaprika
    public static var coins: Request<[Coin]> {
        return Request<[Coin]>(baseUrl: apiBaseUrl, method: .get, path: "coins", params: nil)
    }
    
    /// Get ticker information for all coins
    public static func tickers(quotes: [QuoteCurrency]) -> Request<[Ticker]> {
        return Request<[Ticker]>(baseUrl: apiBaseUrl, method: .get, path: "tickers", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Get ticker information for specific coin
    ///
    /// - Parameter id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func ticker(id: String, quotes: [QuoteCurrency]) -> Request<Ticker> {
        return Request<Ticker>(baseUrl: apiBaseUrl, method: .get, path: "tickers/\(id)", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    public enum SearchCategory: String, CaseIterable {
        case currencies
        case exchanges
        case icos
        case people
        case tags
    }
    
    public static func search(query: String, categories: [SearchCategory] = SearchCategory.allCases, limit: UInt = 6) -> Request<SearchResults> {
        return Request<SearchResults>(baseUrl: apiBaseUrl, method: .get, path: "search", params: ["q": query, "c": categories.map({ $0.rawValue }).joined(separator: ","), "limit": "\(limit)"])
    }
    
    public enum TagsAdditionalFields: String, CaseIterable, QueryRepresentable {
        case coins
    }

    public static func tags(additionalFields: [TagsAdditionalFields] = []) -> Request<[Tag]> {
        return Request<[Tag]>(baseUrl: apiBaseUrl, method: .get, path: "tags", params: ["additional_fields": additionalFields.asCommaJoinedList])
    }
    
    public static func tag(id: String, additionalFields: [TagsAdditionalFields] = []) -> Request<Tag> {
        return Request<Tag>(baseUrl: apiBaseUrl, method: .get, path: "tags/\(id)", params: ["additional_fields": additionalFields.asCommaJoinedList])
    }
    
    public static func exchanges(quotes: [QuoteCurrency]) -> Request<[Exchange]> {
        return Request<[Exchange]>(baseUrl: apiBaseUrl, method: .get, path: "exchanges", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    public static func exchange(id: String, quotes: [QuoteCurrency]) -> Request<Exchange> {
        return Request<Exchange>(baseUrl: apiBaseUrl, method: .get, path: "exchanges/\(id)", params: ["quotes": quotes.asCommaJoinedList])
    }
}
