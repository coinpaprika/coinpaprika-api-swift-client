//
//  Decoder.swift
//  CoinpaprikaAPI
//
//  Created by Dominique Stranz on 05/11/2018.
//

import Foundation

public protocol CodableModel {
    static var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy? {get}
    static var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy? {get}
    static var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? {get}
    static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? {get}
    
    static var decoder: JSONDecoder {get}
    static var encoder: JSONEncoder {get}
}

internal struct AnyKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init?(stringValue: String) {
        self.stringValue = stringValue
        self.intValue = nil
    }
    
    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}

public extension CodableModel {
    public static var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy? {
        return .custom { (components) in
            let component = components.last!
            let words = component.stringValue.split(separator: "_")
            
            if words.count == 1 { // It's already camellCase?
                return component
            }
            
            let name = words.first! + words.dropFirst().map({ $0.prefix(1).uppercased() + $0.dropFirst() }).joined()
            return AnyKey(stringValue: String(name))!
        }
    }
    
    public static var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy? {
        return nil
    }
    
    public static var dateEncodingStrategy: JSONEncoder.DateEncodingStrategy? {
        return .iso8601
    }
    
    public static var dateDecodingStrategy: JSONDecoder.DateDecodingStrategy? {
        return .iso8601
    }
    
    public static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        
        if let keyDecodingStrategy = keyDecodingStrategy {
            decoder.keyDecodingStrategy = keyDecodingStrategy
        }
        
        if let dateDecodingStrategy = dateDecodingStrategy {
            decoder.dateDecodingStrategy = dateDecodingStrategy
        }
        
        return decoder
    }
    
    public static var encoder: JSONEncoder {
        let encoder = JSONEncoder()
        
        if let keyEncodingStrategy = keyEncodingStrategy {
            encoder.keyEncodingStrategy = keyEncodingStrategy
        }
        
        if let dateEncodingStrategy = dateEncodingStrategy {
            encoder.dateEncodingStrategy = dateEncodingStrategy
        }
        
        return encoder
    }
}

extension Array: CodableModel where Element: CodableModel {
    public static var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy? {
        return Element.keyDecodingStrategy
    }
    
    public static var keyEncodingStrategy: JSONEncoder.KeyEncodingStrategy? {
        return Element.keyEncodingStrategy
    }
    
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
