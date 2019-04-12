//
//  Event.swift
//  Pods
//
//  Created by Dominique Stranz on 14/11/2018.
//

import Foundation

/// Event
public struct Event: Equatable, CodableModel {
    
    /// Event id, eg. 2113-bitcoin-conference
    public let id: String
    
    /// Event name, eg. Bitcoin Conference
    public let name: String
    
    // Event description
    public let description: String

    /// Event start date
    public let date: Date
    
    /// Event end date
    public let dateTo: Date?
    
    /// Is it conference
    public let isConference: Bool
    
    /// Event link
    public let link: URL?
    
    /// Proof image
    public let proofImageLink: URL?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case date
        case dateTo = "date_to"
        case isConference = "is_conference"
        case link
        case proofImageLink = "proof_image_link"
    }
    
    
}
