//
//  Tag.swift
//  Pods
//
//  Created by Dominique Stranz on 27/09/2018.
//

import Foundation

/// Tag for ICO & Coins
public struct Tag: Codable, Equatable, CodableModel {
    
    /// Tag id, eg. smart-contracts
    public let id: String
    
    /// Tag name, eg. Smart Contracts
    public let name: String
    
    /// Tag description
    public let description: String?
    
    /// Number of coins connected to this tag
    public let coinCounter: Int
    
    /// Number of ICOs connected to this tag
    public let icoCounter: Int
    
    /// Tag type from `TypeCategory`
    public let type: TypeCategory
    
    /// IDs of coins connected with this Tag
    /// - it's optional value, available only when additionalFields=coins was added to request
    public let coins: [String]?
    
    /// Tag categories
    ///
    /// - functional: Functional Tags
    /// - technical: Technical Tags
    public enum TypeCategory: String, Codable, CaseIterable {
        case functional
        case technical
    }
}
