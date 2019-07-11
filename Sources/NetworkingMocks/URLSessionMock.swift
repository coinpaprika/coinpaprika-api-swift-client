//
//  URLSessionMock.swift
//  
//
//  Created by Dominique Stranz on 10/07/2019.
//

import Foundation
import Networking

public class URLSessionMock<Model: Encodable>: NetworkSession {
    let responseObject: Model
    
    public init(_ responseObject: Model) {
        self.responseObject = responseObject
    }
    
    public func loadData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])
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
