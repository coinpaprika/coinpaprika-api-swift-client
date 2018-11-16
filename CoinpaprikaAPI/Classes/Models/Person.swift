//
//  Person.swift
//  Pods
//
//  Created by Dominique Stranz on 14/11/2018.
//

import Foundation

public struct Person: Codable, Equatable, CodableModel {
    
    /// Person id, eg. satoshi-nakamoto
    public let id: String
    
    /// Person name, eg. Satoshi Nakamoto
    public let name: String
    
    /// Person description
    public let description: String?
    
    /// Number of teams/projects in which this person is involved
    public let teamsCount: Int
    
    /// Person position in project
    public struct Position: Codable, Equatable {
        
        /// Coin id, eg. btc-bitcoin
        let coinId: String
        
        /// Person position, eg. Advisor
        let position: String
    }
    
    /// Position per projects
    public let positions: [Position]?
    
    /// Links with popularity
    public struct Link: Codable, Equatable {
        
        /// Link url
        public let url: URL
        
        /// Number of followers (if supported)
        public let followers: Int?
    }
    
    public struct Links: Codable, Equatable {
        public let github: [Link]?
        public let linkeding: [Link]?
        public let medium: [Link]?
        public let twitter: [Link]?
    }
    
    public let links: Links
}