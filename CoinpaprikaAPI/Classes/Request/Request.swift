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
                callback(Response.failure(RequestError.unableToEncodeParams))
            }
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let error = error {
                callback(Response.failure(error))
            } else {
                guard let data = data else {
                    callback(Response.failure(RequestError.emptyResponse))
                    return
                }
                
                let decoder = JSONDecoder()
                guard let value = try? decoder.decode(Model.self, from: data) else {
                    callback(Response.failure(RequestError.unableToDecodeResponse))
                    return
                }
                
                callback(Response.success(value))
            }
            }.resume()
    }
}


enum RequestMethod: String {
    case get
    case post
    case put
    case delete
}

public enum RequestError: Error {
    case emptyResponse
    case unableToEncodeParams
    case unableToDecodeResponse
    case customError(code: String, message: String)
}
