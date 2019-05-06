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
    case emptyResponse(url: URL?)
    case unableToDecodeResponse(url: URL?)
    case requestsLimitExceeded(url: URL?)
    case invalidRequest(httpCode: Int, url: URL?, message: String?)
    case serverError(httpCode: Int, url: URL?)
    
    public var url: URL? {
        switch self {
        case .emptyResponse(let url),
            .unableToDecodeResponse(let url),
            .requestsLimitExceeded(let url),
            .invalidRequest(_, let url, _),
            .serverError(_, let url):
            return url
        }
    }
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
        case .invalidRequest(let httpCode, _, let message):
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
        case .invalidRequest(let httpCode, _, _):
            return httpCode
        case .serverError(let httpCode, _):
            return httpCode
        default:
            return 0
        }
    }
}
