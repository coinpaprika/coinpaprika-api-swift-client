//
//  Tag.swift
//  Pods
//
//  Created by Dominique Stranz on 27/09/2018.
//

import Foundation

public struct Tag: Codable, Equatable, CodableModel, TagType {
    public let id: String
    public let name: String
    public let description: String?
    public let coinCounter: Int
    public let icoCounter: Int
    public let type: TypeCategory
    
    public enum TypeCategory: String, Codable, CaseIterable {
        case functional
        case technical
    }
}

public protocol TagType: Codable {
    var id: String { get }
    var name: String { get }
}
