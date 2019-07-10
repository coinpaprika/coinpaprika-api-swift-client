//
//  ServiceResponse.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 06.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

#if swift(>=4.3)
/// Result type already built-in
#else
/// Response returned by all requests
public enum Result<Success, Failure> {
    /// Success case with associated Model
    case success(_ value: Success)
    
    /// Failure case with associated Error
    case failure(_ error: Failure)
}
#endif

extension Result where Success: DecodableModel {
    
    /// Model, non empty on .success
    public var value: Success? {
        guard case .success(let value) = self else {
            return nil
        }
        
        return value
    }
    
    /// Error, non empty on .failure
    public var error: Failure? {
        guard case .failure(let error) = self else {
            return nil
        }
        
        return error
    }
}
