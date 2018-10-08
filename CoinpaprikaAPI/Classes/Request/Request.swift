//
//  Request.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

public struct Request<Model: Decodable> {
    let baseUrl = URL(string: "https://api.coinpaprika.com/v1/")!

    let method: RequestMethod
    
    let path: String
    
    let params: [String: String]?
    
    /// Perform API request
    ///
    /// - Parameters:
    ///   - responseQueue: The queue on which the completion handler is dispatched.
    ///   - callback: Completion handler triggered on request success & failure
    public func perform(responseQueue: DispatchQueue? = nil, _ callback: @escaping (Response<Model>) -> Void) {
        let onQueue = { (_ block: @escaping () -> Void) -> Void in
            (responseQueue ?? DispatchQueue.main).async(execute: block)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(userAgent, forHTTPHeaderField: "User-Agent")
        
        do {
            request.httpBody = try encodeBody()
        } catch {
            onQueue {
                callback(Response.failure(ResponseError.unableToEncodeParams))
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                onQueue {
                    callback(Response.failure(error))
                }
            } else {
                guard let httpResponse = urlResponse as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    onQueue {
                        callback(Response.failure(self.findFailureReason(data: data, response: urlResponse)))
                    }
                    return
                }
                
                guard let data = data else {
                    onQueue {
                        callback(Response.failure(ResponseError.emptyResponse))
                    }
                    return
                }
                
                guard let value = self.decodeResponse(data) else {
                    onQueue {
                        callback(Response.failure(ResponseError.unableToDecodeResponse))
                    }
                    return
                }
                
                onQueue {
                    callback(Response.success(value))
                }
            }
        }.resume()
    }
    
    private var url: URL {
        let url = baseUrl.appendingPathComponent(path)
        
        guard method == .get, let params = params, var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return url
        }
        
        var queryItems = components.queryItems ?? []
        
        for (key, value) in params {
            queryItems.append(URLQueryItem(name: key, value: value))
        }
        
        components.queryItems = queryItems
        return components.url!
    }
    
    private var userAgent: String {
        return "Coinpaprika API Client - Swift"
    }
    
    private func encodeBody() throws -> Data? {
        guard method != .get, let params = params else {
            return nil
        }
        
        return try JSONSerialization.data(withJSONObject: params, options: [])
    }

    private func findFailureReason(data: Data?, response: URLResponse?) -> ResponseError {
        guard let response = response as? HTTPURLResponse else {
            return .emptyResponse
        }
        
        switch response.statusCode {
        case 429:
            return .requestsLimitExceeded
        case 400 ..< 500:
            let decoder = JSONDecoder()
            if let data = data, let value = try? decoder.decode(APIError.self, from: data) {
                return .invalidRequest(httpCode: response.statusCode, message: value.error)
            }
            
            return .invalidRequest(httpCode: response.statusCode, message: nil)
        default: break
        }
        
        return .serverError(httpCode: response.statusCode)
    }
    
    private func decodeResponse(_ data: Data) -> Model? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .secondsSince1970
        
        do {
            return try decoder.decode(Model.self, from: data)
        } catch DecodingError.dataCorrupted(let context) {
            assertionFailure("\(Model.self): \(context.debugDescription)")
        } catch DecodingError.keyNotFound(let key, let context) {
            assertionFailure("\(Model.self): \(key.stringValue) was not found, \(context.debugDescription)")
        } catch DecodingError.typeMismatch(let type, let context) {
            assertionFailure("\(Model.self): \(type) was expected, \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            assertionFailure("\(Model.self): no value was found for \(type), \(context.debugDescription)")
        } catch {
            assertionFailure("\(Model.self): unknown decoding error")
        }
        
        return nil
    }
}

struct APIError: Decodable {
    let error: String
}

enum RequestMethod: String {
    case get
    case post
    case put
    case delete
}

public enum ResponseError: Error {
    case emptyResponse
    case unableToEncodeParams
    case unableToDecodeResponse
    case requestsLimitExceeded
    case invalidRequest(httpCode: Int, message: String?)
    case serverError(httpCode: Int)
}
