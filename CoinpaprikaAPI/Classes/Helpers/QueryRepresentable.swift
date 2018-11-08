//
//  QueryRepresentable.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 08/11/2018.
//

import Foundation

protocol QueryRepresentable {
    var queryValue: String { get }
}

internal extension Array where Element: QueryRepresentable {
    internal var queryValues: [String] {
        return map { "\($0.queryValue)" }
    }
    
    internal var asCommaJoinedList: String {
        return queryValues.joined(separator: ",")
    }
}

extension QueryRepresentable where Self: RawRepresentable {
    var queryValue: String {
        return "\(rawValue)"
    }
}
