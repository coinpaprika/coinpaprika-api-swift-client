//
//  Decoder.swift
//  CoinpaprikaAPI
//
//  Created by Dominique Stranz on 05/11/2018.
//

import Foundation

/// Helper providing informations to sucessfully encode/decode each model.
/// Each CoinapaprikaAPI Model conforms to this protocol.
/// Use decoder/encoder properties if you want to store our models.
public protocol CodableModel {
    /// JSONDecoder ready to decode the model.
    static var decoder: JSONDecoder {get}
    
    /// JSONDecoder ready to encode the model.
    static var encoder: JSONEncoder {get}
    
    /// DateDecodingStrategy for JSONDecoder, it could be either iso8601 or unix timestamp.
    /// Use it only if you want to build your own decoder.
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? {get}
    
    /// DateEncodingStrategy for JSONEncoder, it could be either iso8601 or unix timestamp.
    /// Use it only if you want to build your own encoder.
    static var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? {get}
}

public extension CodableModel {
    static var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? {
        return .iso8601
    }
    
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
    
    static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        
        if let dateEncodingStrategy = dateEncodingStrategy {
            encoder.dateEncodingStrategy = dateEncodingStrategy
        }
        
        return encoder
    }
}

extension Array: CodableModel where Element: CodableModel {
    public static var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? {
        return Element.dateEncodingStrategy
    }
    
    public static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? {
        return Element.dateDecodingStrategy
    }
    
    public static var decoder: JSONDecoder {
        return Element.decoder
    }
    
    public static var encoder: JSONEncoder {
        return Element.encoder
    }
}
