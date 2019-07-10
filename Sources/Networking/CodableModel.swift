//
//  Decoder.swift
//  CoinpaprikaAPI
//
//  Created by Dominique Stranz on 05/11/2018.
//

import Foundation

public typealias CodableModel = DecodableModel & EncodableModel

/// Helper providing informations to sucessfully decode each model.
/// Each CoinapaprikaAPI Model conforms to this protocol.
/// Use decoder properties if you want to store our models.
public protocol DecodableModel: Decodable {
    /// JSONDecoder ready to decode the model.
    static var decoder: JSONDecoder {get}
    
    /// DateDecodingStrategy for JSONDecoder, it could be either iso8601 or unix timestamp.
    /// Use it only if you want to build your own decoder.
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? {get}
}

/// Helper providing informations to sucessfully encode each model.
/// Each CoinapaprikaAPI Model conforms to this protocol.
/// Use encoder properties if you want to store our models.
public protocol EncodableModel: Encodable {
    /// JSONDecoder ready to encode the model.
    static var encoder: JSONEncoder {get}
    
    /// DateEncodingStrategy for JSONEncoder, it could be either iso8601 or unix timestamp.
    /// Use it only if you want to build your own encoder.
    static var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? {get}
}

public extension DecodableModel {
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? {
        return .iso8601
    }
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        
        if let dateDecodingStrategy = dateDecodingStrategy {
            decoder.dateDecodingStrategy = dateDecodingStrategy
        }
        
        return decoder
    }
}

public extension EncodableModel {
    static var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? {
        return .iso8601
    }

    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        
        if let dateEncodingStrategy = dateEncodingStrategy {
            encoder.dateEncodingStrategy = dateEncodingStrategy
        }
        
        return encoder
    }
}


extension Array: DecodableModel where Element: DecodableModel {
    public static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? {
        return Element.dateDecodingStrategy
    }
    
    public static var decoder: JSONDecoder {
        return Element.decoder
    }
}


extension Array: EncodableModel where Element: EncodableModel {
    public static var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? {
        return Element.dateEncodingStrategy
    }
    
    public static var encoder: JSONEncoder {
        return Element.encoder
    }
}
