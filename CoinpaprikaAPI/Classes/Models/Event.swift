//
//  Event.swift
//  Pods
//
//  Created by Dominique Stranz on 14/11/2018.
//

import Foundation

/// Event
public struct Event: Codable, Equatable, CodableModel {
    
    /// Event name, eg. Bitcoin Conference
    public let name: String

    /// Event start date
    public let date: Date
    
    /// Event end date
    public let dateTo: Date?
    
    /// Is it conference
    public let isConference: Bool
    
    /// Event link
    public let link: URL
    
    /// Proof image
    public let proofImageLink: URL?
    
}
