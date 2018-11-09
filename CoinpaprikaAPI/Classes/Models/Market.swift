//
//  Market.swift
//  Pods
//
//  Created by Dominique Stranz on 08/11/2018.
//

import Foundation

public struct Market: Codable, Equatable, CodableModel {
    public let pair: String
    public let baseCurrencyId: String
    public let baseCurrencyName: String
    public let quoteCurrencyId: String
    public let quoteCurrencyName: String
    public let marketUrl: URL
    public let category: Category
    public let feeType: FeeType
    public let outlier: Bool
    public let volumePercentage: Decimal
    public let lastUpdated: Date
    
    private let quotes: [String: Quote]
    
    public subscript(_ currency: QuoteCurrency) -> Quote! {
        assert(quotes[currency.code] != nil, "Invalid quote value \(currency). Check if you included \(currency) in request params.")
        return quotes[currency.code]
    }
    
    public struct Quote: Codable, Equatable {
        let price: Decimal
        let volume24h: Decimal
    }
    
    public enum Category: String, Codable {
        case spot = "Spot"
        case derivatives = "Derivatives"
        case otc = "OTC"
    }
    
    public enum FeeType: String, Codable {
        case percentage = "Percentage"
        case noFees = "No Fees"
        case transactionMining = "Transaction Mining"
        case unknown = "Unknown"
    }
}
