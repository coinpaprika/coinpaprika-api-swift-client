//
//  Coin.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation
#if canImport(CoinpaprikaNetworking)
import CoinpaprikaNetworking
#endif

public protocol CoinType {
    var id: String { get }
    var name: String { get }
    var symbol: String { get }
}

/// Coin
public struct Coin: Equatable, CodableModel, CoinType {
    
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
    
    private let typeStorage: TypeValue?
    
    /// Coin type, eg. .coin, .token
    public var type: TypeValue {
        return typeStorage ?? .unknown
    }
    
    /// Logo revision, filled when additionalFields contains .imgRev option
    public var imgRev: Int?
    
    /// Smart contract address, filled when additionalFields contains .contract option
    public var contract: String?
    
    /// Smart contract platform, filled when additionalFields contains .contract option
    public var platform: String?
    
    /// Smart contract platforms, filled when additionalFields contains .contracts option
    public var contracts: [Contract]?
    
    public struct Contract: Codable, Equatable {
        public let contract: String
        public let platform: String
        public let type: String
    }
    
    public enum TypeValue: String, Codable {
        case coin
        case token
        case unknown
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case rank
        case isNew = "is_new"
        case isActive = "is_active"
        case typeStorage = "type"
        case imgRev = "img_rev"
        case contract
        case platform
        case contracts
    }
    
    init(id: String, name: String, symbol: String, rank: Int, isNew: Bool = false, isActive: Bool = true, typeStorage: TypeValue? = nil) {
        self.id = id
        self.name = name
        self.symbol = symbol
        self.rank = rank
        self.isNew = isNew
        self.isActive = isActive
        self.typeStorage = typeStorage
    }
}

public struct CoinExtended: Equatable, CodableModel, CoinType {
    
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
    
    public struct ParentCoin: Codable, Equatable, CoinType {
        /// Coin id, eg. btc-bitcoin
        public let id: String
        
        /// Coin name, eg. Bitcoin
        public let name: String
        
        /// Coin symbol, eg. BTC
        public let symbol: String
    }
    
    public let parent: ParentCoin?
    
    public let tags: [Tag]?
    
    public typealias Tag = SearchResults.Tag
    
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
    
    // Coin project description
    public let description: String?
    
    /// Coin moderation message
    public let message: String?
    
    /// Is it Open Source project?
    public let openSource: Bool
    
    /// Project start date
    public let startedAt: Date?
    
    /// Project development status, eg. Beta version
    public let developmentStatus: String?
    
    /// Does it have a hardware wallet?
    public let hardwareWallet: Bool
    
    /// Coin Proof of Type, eg. Proof of stake
    public let proofType: String?
    
    /// Project organisation stucture, eg. Semi-centralized
    public let orgStructure: String?
    
    /// Coin hash algorithm, eg. SHA256
    public let hashAlgorithm: String?
    
    /// Project links
    public let links: [Link]
    
    /// Coin Whitepaper
    public struct Whitepaper: Codable, Equatable {
        
        /// Link to whitepaper document
        public let link: URL?
        
        /// Link to the thumbnail of document
        public let thumbnail: URL?
    }

    /// Coin whitepaper
    public let whitepaper: Whitepaper
    
    private let typeStorage: Coin.TypeValue?
    
    /// Coin type, eg. .coin, .token
    public var type: Coin.TypeValue {
        return typeStorage ?? .unknown
    }
    
    /// First ticker data
    public let firstDataAt: Date?
    
    /// Last ticker data
    public let lastDataAt: Date?
    
    /// Smart contract address
    public var contract: String?
    
    /// Smart contract platform
    public var platform: String?
    
    /// Smart contract platform
    public var contracts: [Coin.Contract]?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case rank
        case parent
        case isNew = "is_new"
        case isActive = "is_active"
        case tags
        case team
        case description
        case message
        case openSource = "open_source"
        case startedAt = "started_at"
        case developmentStatus = "development_status"
        case hardwareWallet = "hardware_wallet"
        case proofType = "proof_type"
        case orgStructure = "org_structure"
        case hashAlgorithm = "hash_algorithm"
        case links = "links_extended"
        case whitepaper
        case typeStorage = "type"
        case firstDataAt = "first_data_at"
        case lastDataAt = "last_data_at"
        case contract
        case platform
        case contracts
    }
}
