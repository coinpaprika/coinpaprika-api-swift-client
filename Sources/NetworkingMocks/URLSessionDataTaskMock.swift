//
//  URLSessionDataTaskMock.swift
//  
//
//  Created by Dominique Stranz on 10/07/2019.
//

import Foundation

public class URLSessionDataTaskMock: URLSessionDataTask {
    private let closure: () -> Void
    
    public init(closure: @escaping () -> Void) {
        self.closure = closure
    }
    
    // We override the 'resume' method and simply call our closure
    // instead of actually resuming any task.
    override public func resume() {
        closure()
    }
}
