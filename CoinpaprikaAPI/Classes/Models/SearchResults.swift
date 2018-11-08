//
//  SearchResults.swift
//  Pods
//
//  Created by Dominique Stranz on 27/09/2018.
//

import Foundation

public struct SearchResults: Codable, Equatable, CodableModel {
    public let currencies: [Coin]?
    public let icos: [Ico]?
    public let exchanges: [Exchange]?
    public let people: [Person]?
    public let tags: [Tag]?
    
    public typealias Currency = Coin
    
    public struct Person: Codable, Equatable {
        public let id: String
        public let name: String
        public let teamsCount: Int
    }
    
    public struct Ico: Codable, Equatable {
        public let id: String
        public let name: String
        public let symbol: String
        public let isNew: Bool
    }
    
    public struct Exchange: Codable, Equatable {
        public let id: String
        public let name: String
        public let rank: Int
    }
    
    public struct Tag: Codable, Equatable {
        public let id: String
        public let name: String
        public let coinCounter: Int
        public let icoCounter: Int
    }
}
