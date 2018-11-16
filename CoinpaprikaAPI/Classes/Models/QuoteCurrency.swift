//
//  Quote.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 07/11/2018.
//

import Foundation

/// Quote Currency - for use as query parameter and to access quote values in desired currency
public enum QuoteCurrency: String, Codable, CaseIterable {
    /// United States dollar
    case usd
    
    /// Bitcoin
    case btc
    
    /// Ethereum
    case eth
    
    /// Polish zloty
    case pln
    
    /// Currency code, eg. USD
    public var code: String {
        return rawValue.uppercased()
    }
    
    /// Currency symbol, eg. $
    public var symbol: String {
        switch self {
        case .usd:
            return "$"
        case .btc:
            return "₿"
        case .eth:
            return "Ξ"
        case .pln:
            return "zł"
        }
    }
}

extension QuoteCurrency: QueryRepresentable {
    var queryValue: String {
        return code
    }
}
