//
//  Quote.swift
//  AMScrollingNavbar
//
//  Created by Dominique Stranz on 07/11/2018.
//

import Foundation

public enum QuoteCurrency: String, Codable, Hashable {
    case usd = "USD"
    case btc = "BTC"
    case etc = "ETC"
}

public enum QuoteCurrency2: String, Codable, Hashable {
    case usd = "USD"
    case btc = "BTC"
    case etc = "ETC"
}

internal extension Array where Element: RawRepresentable {
    internal var rawValues: [String] {
        return map { "\($0.rawValue)" }
    }
    
    internal var asCommaJoinedList: String {
        return rawValues.joined(separator: ",")
    }
}
