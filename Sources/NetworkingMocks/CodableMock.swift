//
//  CodableMock.swift
//  
//
//  Created by Dominique Stranz on 10/07/2019.
//

import Foundation
import CoinpaprikaNetworking

public class CodableMock<Model: Encodable>: NetworkSession {
    let responseObject: Model
    let statusCode: Int
    
    public init(_ responseObject: Model, statusCode: Int = 200) {
        self.responseObject = responseObject
        self.statusCode = statusCode
    }
    
    public func loadData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])
        completionHandler(self.responseData, response, nil)
    }
    
    private var encoder: JSONEncoder {
        guard let decodableModel = Model.self as? EncodableModel.Type else {
            return JSONEncoder()
        }
        
        return decodableModel.encoder
    }
    
    private var responseData: Data? {
        return try? encoder.encode(responseObject)
    }
}
