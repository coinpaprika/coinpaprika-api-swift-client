//
//  Quote.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 07/11/2018.
//

import Foundation

/// Quote Currency - for use as query parameter and to access quote values in desired currency
public enum QuoteCurrency: String, Codable, CaseIterable {
    case usd
    case btc
    case eth
    case pln
    
    public var code: String {
        return rawValue.uppercased()
    }
    
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
