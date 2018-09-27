//
//  SearchResults.swift
//  Pods
//
//  Created by Dominique Stranz on 27/09/2018.
//

import Foundation

public struct SearchResults: Decodable, Equatable {
    public let currencies: [Coin]?
    public let icos: [Ico]?
    public let exchanges: [Exchange]?
    public let people: [Person]?
    public let tags: [Tag]?
}
