//
//  ServiceResponse.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 06.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

public enum Response<Object> {
    case success(_ value: Object)
    case failure(_ error: Error)
    
    public var value: Object? {
        switch self {
        case .success(let value):
            return value
        default:
            return nil
        }
    }
}
