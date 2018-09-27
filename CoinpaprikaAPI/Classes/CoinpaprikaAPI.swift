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
    
    /// Get global information
    public static var global: Request<GlobalStats> {
        return Request<GlobalStats>(method: .get, path: "global", params: nil)
    }
    
    /// Get all coins listed on coinpaprika
    public static var coins: Request<[Coin]> {
        return Request<[Coin]>(method: .get, path: "coins", params: nil)
    }
    
    /// Get ticker information for all coins
    public static var tickers: Request<[Ticker]> {
        return Request<[Ticker]>(method: .get, path: "ticker", params: nil)
    }
    
    /// Get ticker information for specific coin
    ///
    /// - Parameter id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func ticker(id: String) -> Request<Ticker> {
        return Request<Ticker>(method: .get, path: "ticker/\(id)", params: nil)
    }
    
    public enum SearchCategory: String, CaseIterable {
        case currencies
        case exchanges
        case icos
        case people
        case tags
    }
    
    public static func search(query: String, categories: [SearchCategory] = SearchCategory.allCases, limit: UInt = 6) -> Request<SearchResults> {
        return Request<SearchResults>(method: .get, path: "search", params: ["q": query, "c": categories.map({ $0.rawValue }).joined(separator: ","), "limit": "\(limit)"])
    }
}
