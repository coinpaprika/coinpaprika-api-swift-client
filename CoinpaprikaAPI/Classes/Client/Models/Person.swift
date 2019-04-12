//
//  Person.swift
//  Pods
//
//  Created by Dominique Stranz on 14/11/2018.
//

import Foundation

public struct Person: Equatable, CodableModel {
    
    /// Person id, eg. satoshi-nakamoto
    public let id: String
    
    /// Person name, eg. Satoshi Nakamoto
    public let name: String
    
    /// Person description
    public let description: String?
    
    /// Number of teams/projects in which this person is involved
    public let teamsCount: Int
    
    /// Person position in project
    public struct Project: Codable, Equatable {
        
        /// Coin id, eg. btc-bitcoin
        public let coinId: String
        
        /// Coin name, eg. Bitcoin
        public let coinName: String
        
        /// Coin name, eg. BTC
        public let coinSymbol: String
        
        /// Person position, eg. Advisor
        public let position: String
        
        enum CodingKeys: String, CodingKey {
            case coinId = "coin_id"
            case coinName = "coin_name"
            case coinSymbol = "coin_symbol"
            case position
        }
    }
    
    /// Position per projects
    public let positions: [Project]
    
    /// Links with popularity
    public struct Link: Codable, Equatable {
        
        /// Link url
        public let url: URL
        
        /// Number of followers (if supported)
        public let followers: Int?
    }
    
    public struct Links: Codable, Equatable {
        public let github: [Link]?
        public let linkedin: [Link]?
        public let medium: [Link]?
        public let twitter: [Link]?
    }
    
    public let links: Links
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case teamsCount = "teams_count"
        case positions
        case links
    }
}
