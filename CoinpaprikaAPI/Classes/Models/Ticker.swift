//
//  Ticker.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 05.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

public struct Ticker: Codable, Equatable, CodableModel {
    public let id: String
    public let name: String
    public let symbol: String
    public let rank: Int
    
    public let circulatingSupply: Int64
    public let totalSupply: Int64
    public let maxSupply: Int64
    public let betaValue: Decimal
    
    public let lastUpdated: Date
    
    public let quotes: [String: Quote]
    
    public subscript(_ currency: QuoteCurrency) -> Quote! {
        assert(quotes[currency.code] != nil, "Invalid quote value \(currency). Check if you included \(currency) in request params.")
        return quotes[currency.code]
    }
    
    public struct Quote: Codable, Equatable {
        public let price: Decimal
        public let volume24h: Int64
        public let volume24hChange24h: Decimal
        public let marketCap: Int64
        public let marketCapChange24h: Decimal
        public let percentChange1h: Decimal
        public let percentChange12h: Decimal
        public let percentChange24h: Decimal
        public let percentChange7d: Decimal
        public let percentChange30d: Decimal
        public let percentChange1y: Decimal
        public let athPrice: Decimal?
        public let athDate: Date?
        public let percentFromPriceAth: Decimal?
        
        public var volumeMarketCapRate: Decimal? {
            guard marketCap != 0 else {
                return nil
            }
            
            return Decimal(volume24h)/Decimal(marketCap)
        }
    }

    public var circulatingSupplyPercent: Decimal? {
        guard maxSupply != 0 else {
            return nil
        }
        
        return Decimal(circulatingSupply)/Decimal(maxSupply)
    }
}
