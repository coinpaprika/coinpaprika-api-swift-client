//
//  CoinExchange.swift
//  Pods
//
//  Created by Dominique Stranz on 14/11/2018.
//

import Foundation

/// Coin Exchange
public struct CoinExchange: Codable, Equatable, CodableModel {
    
    /// Coin id, eg. binance
    public let id: String
    
    /// Coin name, eg. Binance
    public let name: String
    
    /// Adjusted volume share in last 24h
    public let adjustedVolume24hShare: Decimal
    
    /// List of supported fiat currencies
    public let fiats: [Exchange.Fiat]?
}
