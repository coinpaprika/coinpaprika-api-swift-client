//
//  TopMovers.swift
//  CoinpaprikaAPI
//
//  Created by Dominique Stranz on 03/01/2019.
//

import Foundation

/// TopMovers
public struct TopMovers: Equatable, CodableModel {
    
    /// Top Gainers
    public let gainers: [Coin]
    
    /// Top Losers
    public let losers: [Coin]
    
    public struct Coin: Codable, Equatable, CoinType {
        /// Coin id, eg. btc-bitcoin
        public let id: String
        
        /// Coin name, eg. Bitcoin
        public let name: String
        
        /// Coin symbol, eg. BTC
        public let symbol: String
        
        /// Coin position in Coinpaprika ranking
        public let rank: Int
        
        /// Percent change
        public let percentChange: Decimal
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case symbol
            case rank
            case percentChange = "percent_change"
        }
    }
}
