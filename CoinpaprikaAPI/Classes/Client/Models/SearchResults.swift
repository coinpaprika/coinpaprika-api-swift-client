//
//  SearchResults.swift
//  Pods
//
//  Created by Dominique Stranz on 27/09/2018.
//

import Foundation

/// Search results wrapper
public struct SearchResults: Equatable, CodableModel {
    
    /// Currencies (coins) matching search criteria
    /// - It will exist only when a request was performed with `currencies` category
    public let currencies: [Coin]?
    
    /// ICOs matching search criteria
    /// - It will exist only when a request was performed with `icos` category
    public let icos: [Ico]?
    
    /// Exchanges matching search criteria
    /// - It will exist only when a request was performed with `exchanges` category
    public let exchanges: [Exchange]?
    
    /// People matching search criteria
    /// - It will exist only when a request was performed with `people` category
    public let people: [Person]?
    
    /// Tags matching search criteria
    /// - It will exist only when a request was performed with `tags` category
    public let tags: [Tag]?
    
    /// Search.Currency model, at the moment it using `Coin` model
    public typealias Currency = Coin
    
    /// Search.Person model
    public struct Person: Codable, Equatable {
        
        /// Person id, eg. satoshi-nakamoto
        public let id: String
        
        /// Person name, eg. Satoshi Nakamoto
        public let name: String
        
        /// Number of teams/projects in which this person is involved
        public let teamsCount: Int
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case teamsCount = "teams_count"
        }
    }
    
    /// Search.Ico model
    public struct Ico: Codable, Equatable {
        
        /// ICO id, eg. mm-moonx
        public let id: String
        
        /// ICO name, eg. MoonX
        public let name: String
        
        /// ICO symbol, eg. MM
        public let symbol: String
        
        /// Is it recently added to Coinpaprika
        public let isNew: Bool
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case symbol
            case isNew = "is_new"
        }
    }
    
    /// Search.Exchange model
    public struct Exchange: Codable, Equatable {
        
        /// Exchange identifier, eg. binance
        public let id: String
        
        /// Exchange name, eg. Binance
        public let name: String
        
        /// Exchange position in Coinpaprika ranking
        public let rank: Int
    }
    
    /// Search.Tag
    public struct Tag: Codable, Equatable, TagType {
        
        /// Tag id, eg. smart-contracts
        public let id: String
        
        /// Tag name, eg. Smart Contracts
        public let name: String
        
        /// Number of coins connected to this tag
        public let coinCounter: Int
        
        /// Number of ICOs connected to this tag
        public let icoCounter: Int
        
        enum CodingKeys: String, CodingKey {
            case id
            case name
            case coinCounter = "coin_counter"
            case icoCounter = "ico_counter"
        }
    }
}
