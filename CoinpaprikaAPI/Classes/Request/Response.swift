//
//  ServiceResponse.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 06.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

/// Response returned by all requests
public enum Response<Object> {
    /// Success case with associated Model
    case success(_ value: Object)
    
    /// Failure case with associated Error
    case failure(_ error: Error)
    
    /// Model, non empty on .success
    public var value: Object? {
        guard case .success(let value) = self else {
            return nil
        }
        
        return value
    }
    
    /// Error, non empty on .failure
    public var error: Error? {
        guard case .failure(let error) = self else {
            return nil
        }
        
        return error
    }
}
