//
//  Exchange.swift
//  Pods
//
//  Created by Dominique Stranz on 27/09/2018.
//

import Foundation

public struct Exchange: Codable, Equatable, CodableModel {
    public let id: String
    public let name: String
    public let active: Bool
    public let message: String?
    public let links: Links?
    public let marketsDataFetched: Bool
    public let adjustedRank: Int?
    public let reportedRank: Int?
    public let currencies: Int
    public let markets: Int
    public let fiats: [Fiat]?
    public let quote: [String: Quote]
    public let lastUpdated: Date
    
    public subscript(_ currency: QuoteCurrency) -> Quote! {
        assert(quote[currency.rawValue] != nil, "Invalid quote value \(currency). Check if you included \(currency) in request params.")
        return quote[currency.rawValue]
    }
    
    public struct Quote: Codable, Equatable {
        public let reportedVolume24h: Int64
        public let adjustedVolume24h: Int64
    }
    
    public struct Links: Codable, Equatable {
        public let twitter: [URL]?
        public let website: [URL]?
        public let blog: [URL]?
        public let chat: [URL]?
        public let fees: [URL]?
        public let telegram: [URL]?
    }
    
    public struct Fiat: Codable, Equatable {
        public let name: String
        public let symbol: String
    }
}

