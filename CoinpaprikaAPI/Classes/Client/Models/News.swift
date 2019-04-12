//
//  News.swift
//  CoinpaprikaAPI
//
//  Created by Dominique Stranz on 03/01/2019.
//

import Foundation

/// News
public struct News: Equatable, CodableModel {
    
    /// News title
    public let title: String
    
    /// News lead
    public let lead: String?
    
    /// News url
    public let url: URL
    
    /// News date
    public let date: Date
    
    enum CodingKeys: String, CodingKey {
        case title
        case lead
        case url
        case date = "news_date"
    }
    
}
