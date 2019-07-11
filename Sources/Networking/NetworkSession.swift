//
//  NetworkSession.swift
//  
//
//  Created by Dominique Stranz on 11/07/2019.
//

import Foundation

public protocol NetworkSession {
    func loadData(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void)
}

extension URLSession: NetworkSession {
    public func loadData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let task = dataTask(with: request) { (data, response, error) in
            completionHandler(data, response, error)
        }
        
        task.resume()
    }
}
