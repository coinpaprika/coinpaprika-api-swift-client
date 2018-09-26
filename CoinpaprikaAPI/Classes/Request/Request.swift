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
    
    let params: Any?
    
    public func perform(_ callback: @escaping (Response<Model>) -> Void) {
        var request = URLRequest(url: baseUrl.appendingPathComponent(path))
        request.httpMethod = method.rawValue.uppercased()
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let build = Bundle.main.infoDictionary?["CFBundleShortVersionString"] ?? "Unknown"
        request.addValue("Coinpaprika API Client - Swift (v.\(build))", forHTTPHeaderField: "User-Agent")
        
        if let params = params {
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
            } catch {
                callback(Response.failure(ResponseError.unableToEncodeParams))
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            if let error = error {
                callback(Response.failure(error))
            } else {
                guard let httpResponse = urlResponse as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                    callback(Response.failure(self.findFailureReason(data: data, response: urlResponse)))
                    return
                }
                
                guard let data = data else {
                    callback(Response.failure(ResponseError.emptyResponse))
                    return
                }
                
                let decoder = JSONDecoder()
                guard let value = try? decoder.decode(Model.self, from: data) else {
                    callback(Response.failure(ResponseError.unableToDecodeResponse))
                    return
                }
                
                callback(Response.success(value))
            }
            }.resume()
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
        default: break
        }
        
        return .serverError(httpCode: response.statusCode)
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
    case invalidRequest(httpCode: Int, message: String)
    case serverError(httpCode: Int)
}
