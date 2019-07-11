//
//  ErrorsTests.swift
//  CoinpaprikaTests
//
//  Created by Dominique Stranz on 11/07/2019.
//

import XCTest
import Networking

class ErrorsTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRequestLocalizedErrors() {
        XCTAssertNotNil(RequestError.unableToCreateRequest.localizedDescription)
        XCTAssertNotNil(RequestError.unableToEncodeParams.localizedDescription)
    }
    
    func testResponseLocalizedErrors() {
        XCTAssertNotNil(ResponseError.emptyResponse(url: nil).localizedDescription)
        XCTAssertNotNil(ResponseError.unableToDecodeResponse(url: nil).localizedDescription)
        XCTAssertNotNil(ResponseError.requestsLimitExceeded(url: nil).localizedDescription)
        XCTAssertNotNil(ResponseError.serverError(httpCode: 404, url: nil).localizedDescription)
        
        let testMessage = "[TESTMARK]"
        let invalidRequestError = ResponseError.invalidRequest(httpCode: 404, url: nil, message: testMessage)
        XCTAssertNotNil(invalidRequestError.localizedDescription)
        XCTAssertEqual(invalidRequestError.localizedDescription, testMessage)
    }
    
    func testResponseErrorUrl() {
        let url = URL(string: "https://example.org")
        let errors: [ResponseError] = [.emptyResponse(url: url), .unableToDecodeResponse(url: url), .requestsLimitExceeded(url: url), .serverError(httpCode: 404, url: url), .invalidRequest(httpCode: 404, url: url, message: nil)]
        
        for error in errors {
            XCTAssertEqual(error.url, url)
        }
    }
}
