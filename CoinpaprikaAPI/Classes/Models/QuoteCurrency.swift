//
//  Quote.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 07/11/2018.
//

import Foundation

public enum QuoteCurrency: String, Codable, CaseIterable {
    case usd
    case btc
    //   case etc
    
    public var code: String {
        return rawValue.uppercased()
    }
    
    public var symbol: String {
        switch self {
        case .usd:
            return "$"
        case .btc:
            return "₿"
        }
    }
}

extension QuoteCurrency: QueryRepresentable {
    var queryValue: String {
        return code
    }
}
