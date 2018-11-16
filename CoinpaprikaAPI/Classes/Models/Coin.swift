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
    
    public let team: [Person]?
    
    /// Coin.Person model
    public struct Person: Codable, Equatable {
        
        /// Person id, eg. satoshi-nakamoto
        public let id: String
        
        /// Person name, eg. Satoshi Nakamoto
        public let name: String
        
        /// Position in project
        public let position: String
    }
    
    public let description: String?
    
    public let message: String?
    
    public let openSource: Bool
    
    public let startedAt: Date?
    
    public let developmentStatus: String?
    
    public let hardwareWallet: Bool
    
    public let proofType: String?
    
    public let orgStructure: String?
    
    public let hashAlgorithm: String?
    
    public struct Links: Codable, Equatable {
        public let explorer: [URL]?
        public let facebook: [URL]?
        public let reddit: [URL]?
        public let sourceCode: [URL]?
        public let website: [URL]?
        public let medium: [URL]?
        public let youtube: [URL]?
        public let vimeo: [URL]?
        public let videoFile: [URL]?
    }
    
    public let links: Links
    
    public struct Whitepaper: Codable, Equatable {
        public let link: URL?
        public let thumbnail: URL?
    }
    
    public let whitepaper: Whitepaper
    
}
