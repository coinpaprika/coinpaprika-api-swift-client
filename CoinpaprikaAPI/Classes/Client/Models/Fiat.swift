//
//  Fiat.swift
//  Pods
//
//  Created by Dominique Stranz on 23/01/2019.
//

import Foundation

/// Fiat definition
public struct Fiat: Equatable, CodableModel {
    
    /// Coin id, eg. usd-us-dollars
    public let id: String
    
    /// Coin name, eg. US Dollars
    public let name: String

    /// Coin symbol, eg. USD
    public let symbol: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
    }
    
}
