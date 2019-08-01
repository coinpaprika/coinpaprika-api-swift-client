//
//  JsonMock.swift
//  
//
//  Created by Dominique Stranz on 10/07/2019.
//

import Foundation
import Networking

public class JsonMock: NetworkSession {
    let responseData: Data?
    let statusCode: Int
    
    public init(_ responseData: Data?, statusCode: Int = 200) {
        self.responseData = responseData
        self.statusCode = statusCode
    }
    
    public init(_ responseString: String?, statusCode: Int = 200) {
        self.responseData = responseString?.data(using: .utf8)
        self.statusCode = statusCode
    }
    
    public func loadData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let response = HTTPURLResponse(url: request.url!, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])
        completionHandler(self.responseData, response, nil)
    }
}
