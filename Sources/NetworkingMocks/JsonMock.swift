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
    
    public init(_ responseData: Data?) {
        self.responseData = responseData
    }
    
    public init(_ responseString: String?) {
        self.responseData = responseString?.data(using: .utf8)
    }
    
    public func loadData(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: ["Content-Type": "application/json"])
        completionHandler(self.responseData, response, nil)
    }
}
