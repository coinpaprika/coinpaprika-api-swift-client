//
//  Coin.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

public protocol CoinType {
    var id: String { get }
    var name: String { get }
    var symbol: String { get }
    var rank: Int { get }
    var isNew: Bool { get }
    var isActive: Bool { get }
}

/// Coin
public struct Coin: Codable, Equatable, CodableModel, CoinType {
    
    /// Coin id, eg. btc-bitcoin
    public let id: String
    
    /// Coin name, eg. Bitcoin
    public let name: String
    
    /// Coin symbol, eg. BTC
    public let symbol: String
    
    /// Coin position in Coinpaprika ranking
    public let rank: Int
    
    /// Is it recently added to Coinpaprika
    public let isNew: Bool
    
    /// Is it active on Coinpaprika
    public let isActive: Bool
    
}

public struct CoinExtended: Codable, Equatable, CodableModel, CoinType {
    
    /// Coin id, eg. btc-bitcoin
    public let id: String
    
    /// Coin name, eg. Bitcoin
    public let name: String
    
    /// Coin symbol, eg. BTC
    public let symbol: String
    
    /// Coin position in Coinpaprika ranking
    public let rank: Int
    
    /// Is it recently added to Coinpaprika
    public let isNew: Bool
    
    /// Is it active on Coinpaprika
    public let isActive: Bool
    
    public let tags: [Tag]?
    
    public struct Tag: Codable, Equatable {
        /// Tag id, eg. smart-contracts
        public let id: String
        
        /// Tag name, eg. Smart Contracts
        public let name: String
        
        /// Number of coins connected to this tag
        public let coinCounter: Int
        
        /// Number of ICOs connected to this tag
        public let icoCounter: Int
    }
    
    let team: [Person]?
    
    /// Search.Person model
    public struct Person: Codable, Equatable {
        
        /// Person id, eg. satoshi-nakamoto
        public let id: String
        
        /// Person name, eg. Satoshi Nakamoto
        public let name: String
        
        /// Position in project
        public let position: String
    }
    
    let description: String?
    
    let message: String?
    
    let openSource: Bool
    
    let startedAt: Date?
    
    let developmentStatus: String?
    
    public struct Links: Codable, Equatable {
        let explorer: [URL]?
        let facebook: [URL]?
        let reddit: [URL]?
        let sourceCode: [URL]?
        let website: [URL]?
        let medium: [URL]?
        let youtube: [URL]?
    }
    
    let links: Links
    
    public struct Whitepaper: Codable, Equatable {
        let link: URL?
        let thumbnail: URL?
    }
    
    let whitepaper: Whitepaper
    
}
