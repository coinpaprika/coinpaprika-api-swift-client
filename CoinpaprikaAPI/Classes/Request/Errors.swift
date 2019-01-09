//
//  Errors.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 29/11/2018.
//

import Foundation

public enum RequestError: Error {
    case unableToCreateRequest
    case unableToEncodeParams
}

extension RequestError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unableToCreateRequest:
            return "Unable to create request"
        case .unableToEncodeParams:
            return "Unable to encode params"
        }
    }
}

public enum ResponseError: Error {
    case emptyResponse
    case unableToDecodeResponse
    case requestsLimitExceeded
    case invalidRequest(httpCode: Int, message: String?)
    case serverError(httpCode: Int)
}

extension ResponseError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .emptyResponse:
            return "Empty response"
        case .unableToDecodeResponse:
            return "Unable to decode response"
        case .requestsLimitExceeded:
            return "Requests limit exceeded"
        case .invalidRequest(let httpCode, let message):
            guard let message = message else {
                return "Invalid request [\(httpCode)]"
            }
            
            return message
        case .serverError(let httpCode):
            return "Server error [\(httpCode)]"
        }
    }
}

extension ResponseError: CustomNSError {
    public var errorCode: Int {
        switch self {
        case .invalidRequest(let httpCode, _):
            return httpCode
        case .serverError(let httpCode):
            return httpCode
        default:
            return 0
        }
    }
}
