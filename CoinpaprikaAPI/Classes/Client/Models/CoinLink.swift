//
//  CoinLink.swift
//  CoinpaprikaAPI
//
//  Created by Dominique Stranz on 04/01/2019.
//

import Foundation

extension CoinExtended {
    /// Coin link
    public struct Link: Codable, Equatable {
        /// Link url
        public let url: URL
        
        private let typeStorage: LinkType?
        
        /// Link type
        public var type: LinkType {
            return typeStorage ?? .unknown
        }
        
        /// Link stats, for covenience you can use direct properties: subscribers, contributors, stars, etc...
        public let stats: [String: Decimal]?
        
        /// Reddit subscribers count
        public var subscribers: Int? {
            assert(type == .reddit, "Statistic only for type .reddit")
            return int(for: "subscribers")
        }
        
        /// Repository contributors count
        public var contributors: Int? {
            assert(type == .sourceCode, "Statistic only for type .sourceCode")
            return int(for: "contributors")
        }
        
        /// Repository stars count
        public var stars: Int? {
            assert(type == .sourceCode, "Statistic only for type .sourceCode")
            return int(for: "stars")
        }
        
        /// Telegram Group members count
        public var members: Int? {
            assert(type == .telegram, "Statistic only for type .telegram")
            return int(for: "members")
        }
        
        /// Twitter followers count
        public var followers: Int? {
            assert(type == .twitter, "Statistic only for type .twitter")
            return int(for: "followers")
        }
        
        private func int(for key: String) -> Int? {
            guard let decimalValue = stats?[key] else {
                return nil
            }
            
            return NSDecimalNumber(decimal: decimalValue).intValue
        }
        
        public enum LinkType: String, Codable {
            case website
            case explorer
            case announcement
            case messageBoard = "message_board"
            case slack
            case telegram
            case chat
            case discord
            case twitter
            case reddit
            case facebook
            case blog
            case medium
            case steemit
            case sourceCode = "source_code"
            case youtube
            case vimeo
            case videoFile = "video_file"
            case wallet
            case unknown
        }
        
        enum CodingKeys: String, CodingKey {
            case url
            case typeStorage = "type"
            case stats
        }
    }
}

public extension Array where Element == CoinExtended.Link {
    
    /// Filter links array with given type
    ///
    /// - Parameter type: requested link type
    /// - Returns: links array
    func with(type: CoinExtended.Link.LinkType) -> [CoinExtended.Link] {
        return filter({ $0.type == type })
    }
    
    /// Filter links array with given type
    ///
    /// - Parameter type: requested link type
    /// - Returns: links array
    func with(types: [CoinExtended.Link.LinkType]) -> [CoinExtended.Link] {
        return filter({ types.contains($0.type) })
    }
    
}

/// Added for compatibility with previous API version, to be removed in the future
public extension Array where Element == CoinExtended.Link {
    
    /// Project blockchain explorer
    @available(*, deprecated, message: "Use .with(type: .explorer) method directly")
    var explorer: [URL]? {
        return with(type: .explorer).map({ $0.url })
    }
    
    /// Project Facebook profile page
    @available(*, deprecated, message: "Use .with(type: .facebook) method directly")
    var facebook: [URL]? {
        return with(type: .facebook).map({ $0.url })
    }

    /// Project subreddit at Reddit
    @available(*, deprecated, message: "Use .with(type: .reddit) method directly")
    var reddit: [URL]? {
        return with(type: .reddit).map({ $0.url })
    }

    /// Project twitter account
    @available(*, deprecated, message: "Use .with(type: .twitter) method directly")
    var twitter: [URL]? {
        return with(type: .twitter).map({ $0.url })
    }

    /// Project code repository
    @available(*, deprecated, message: "Use .with(type: .sourceCode) method directly")
    var sourceCode: [URL]? {
        return with(type: .sourceCode).map({ $0.url })
    }

    /// Project website
    @available(*, deprecated, message: "Use .with(type: .website) method directly")
    var website: [URL]? {
        return with(type: .website).map({ $0.url })
    }

    /// Project blog at Medium
    @available(*, deprecated, message: "Use .with(type: .medium) method directly")
    var medium: [URL]? {
        return with(type: .medium).map({ $0.url })
    }

    /// Project explanation/marketing video at Youtube
    @available(*, deprecated, message: "Use .with(type: .youtube) method directly")
    var youtube: [URL]? {
        return with(type: .youtube).map({ $0.url })
    }

    /// Project explanation/marketing video at Vimeo
    @available(*, deprecated, message: "Use .with(type: .vimeo) method directly")
    var vimeo: [URL]? {
        return with(type: .vimeo).map({ $0.url })
    }

    /// Project explanation video
    @available(*, deprecated, message: "Use .with(type: .videoFile) method directly")
    var videoFile: [URL]? {
        return with(type: .videoFile).map({ $0.url })
    }

    
}
