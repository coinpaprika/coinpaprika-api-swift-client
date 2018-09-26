//
//  RequestTests.swift
//  CoinpaprikaAPI_Tests
//
//  Created by Dominique Stranz on 25/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import CoinpaprikaAPI

class RequestTests: XCTestCase {
    
    let bitcoinId = "btc-bitcoin"
    
    func testGlobalStatsRequest() {
        let expectation = self.expectation(description: "Waiting for global stats")
        
        CoinpaprikaAPI.global.perform { (response) in
            let stats = response.value
            XCTAssertNotNil(stats, "Stats object should exist")
            
            XCTAssert(stats!.marketCapUsd > 0, "Market cap USD should be greater than 0")
            XCTAssert(stats!.volume24hUsd > 0, "Volume USD 24h should be greater than 0")
            XCTAssert(stats!.cryptocurrenciesNumber > 0, "Cryptocurrencies number should be greater than 0")
            XCTAssert(stats!.bitcoinDominancePercentage > 0, "Bitcoin dominance should be greater than 0")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testCoinsRequest() {
        let expectation = self.expectation(description: "Waiting for coins")
        
        CoinpaprikaAPI.coins.perform { (response) in
            let coins = response.value
            XCTAssertNotNil(coins, "Coins list should exist")
            
            let bitcoin = coins?.first { $0.id == self.bitcoinId }
            XCTAssert(bitcoin?.symbol == "BTC", "BTC not found")
            
            expectation.fulfill()
        }
    
        waitForExpectations(timeout: 30)
    }
    
    func testTickersRequest() {
        let expectation = self.expectation(description: "Waiting for tickers")
        
        CoinpaprikaAPI.tickers.perform { (response) in
            let tickers = response.value
            XCTAssertNotNil(tickers, "Tickers list should exist")
            
            let bitcoin = tickers?.first { $0.id == self.bitcoinId }
            XCTAssert(bitcoin?.symbol == "BTC", "BTC not found")
            XCTAssert(bitcoin?.priceBtc == 1, "1 BTC value in BTC should be equal 1")
            XCTAssert((bitcoin?.priceUsd ?? 0) > 0, "1 BTC value in USD should be greater than 0")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testTickerRequest() {
        let expectation = self.expectation(description: "Waiting for ticker")
        
        
        CoinpaprikaAPI.ticker(id: bitcoinId).perform { (response) in
            let bitcoin = response.value
            
            XCTAssertNotNil(bitcoin, "Ticker should exist")
            XCTAssert(bitcoin?.id == self.bitcoinId, "BTC not found")
            XCTAssert(bitcoin?.symbol == "BTC", "BTC not found")
            XCTAssert(bitcoin?.priceBtc == 1, "1 BTC value in BTC should be equal 1")
            XCTAssert((bitcoin?.priceUsd ?? 0) > 0, "1 BTC value in USD should be greater than 0")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testSuccessResponse() {
        let object = "Test Codable object"
        let response = Response.success(object)
        XCTAssert(response.value == object, "Response value should be equal \(object)")
        XCTAssertNil(response.error, "Response error should be empty")
        
        if case .success(let responseValue) = response {
            XCTAssert(responseValue == object, "Response value should be equal \(object)")
        } else {
            XCTFail("Response should be equal .success")
        }
    }
    
    func testFailureResponse() {
        let error = ResponseError.emptyResponse
        let response = Response<Any>.failure(error)
        guard case .emptyResponse = (response.error as! ResponseError) else {
            XCTFail("Response error should be equal \(error)")
            return
        }
        
        XCTAssertNil(response.value, "Response value should be empty")
        
        guard case .failure(let responseError) = response, case .emptyResponse = (responseError as! ResponseError) else {
            XCTFail("Response should be equal .failure")
            return
        }
    }
    
    func testRequestError() {
        let expectation = self.expectation(description: "Waiting for ticker")
        
        CoinpaprikaAPI.ticker(id: "unexisting-coin-id").perform { (response) in
            let expectedCode = 404
            let expectedMessage = "id not found"
            
            XCTAssertNil(response.value, "Response value should be empty")
            let responseError = (response.error as? ResponseError)
            XCTAssertNotNil(responseError, "Response error shouldn't be empty")
            
            if case .invalidRequest(let code, let message) = responseError! {
                XCTAssert(code == expectedCode, "Error code should be equal to \(expectedCode)")
                XCTAssert(message == expectedMessage, "Error message should be equal to \(expectedMessage)")
            } else {
                XCTFail("Error should be equal to .invalidRequest with proper associated values")
            }
            
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 30)
    }
}
