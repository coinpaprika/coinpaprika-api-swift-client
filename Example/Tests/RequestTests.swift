//
//  RequestTests.swift
//  CoinpaprikaAPI_Tests
//
//  Created by Dominique Stranz on 25/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import Coinpaprika

class RequestTests: XCTestCase {
    
    let bitcoinId = "btc-bitcoin"
    let satoshiId = "satoshi-nakamoto"
    let binanceId = "binance"
    
    func testGlobalStatsRequest() {
        let expectation = self.expectation(description: "Waiting for global stats")
        
        Coinpaprika.API.global().perform { (response) in
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
        
        Coinpaprika.API.coins().perform { (response) in
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
        
        Coinpaprika.API.tickers(quotes: [.usd, .btc]).perform { (response) in
            let tickers = response.value
            XCTAssertNotNil(tickers, "Tickers list should exist")
            
            let bitcoin = tickers?.first { $0.id == self.bitcoinId }
            XCTAssert(bitcoin?.symbol == "BTC", "BTC not found")
            XCTAssert(bitcoin?[.btc].price == 1, "1 BTC value in BTC should be equal 1")
            XCTAssert((bitcoin?[.usd].price ?? 0) > 0, "1 BTC value in USD should be greater than 0")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testTickerRequest() {
        let expectation = self.expectation(description: "Waiting for ticker")
        
        
        Coinpaprika.API.ticker(id: bitcoinId, quotes: [.usd, .btc]).perform { (response) in
            let bitcoin = response.value
            
            XCTAssertNotNil(bitcoin, "Ticker should exist")
            XCTAssert(bitcoin?.id == self.bitcoinId, "BTC not found")
            XCTAssert(bitcoin?.symbol == "BTC", "BTC not found")
            XCTAssert(bitcoin?[.btc].price == 1, "1 BTC value in BTC should be equal 1")
            XCTAssert((bitcoin?[.usd].price ?? 0) > 0, "1 BTC value in USD should be greater than 0")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testSearchRequest() {
        let expectation = self.expectation(description: "Waiting for search results")
        
        Coinpaprika.API.search(query: "bitcoin", categories: Coinpaprika.API.SearchCategory.allCases, limit: 15).perform { (response) in
    
            let searchResults = response.value
            XCTAssertNotNil(searchResults)
            
            let coins = searchResults?.currencies
            XCTAssertNotNil(coins)
            XCTAssert(coins!.count > 0, "We should have at least 1 coin for Bitcoin")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testSearchWithoutCoins() {
        let expectation = self.expectation(description: "Waiting for search results")
        
        Coinpaprika.API.search(query: "bitcoin", categories: [.exchanges, .icos, .people, .tags], limit: 15).perform { (response) in
            
            let searchResults = response.value
            XCTAssertNotNil(searchResults)
            
            let coins = searchResults?.currencies
            XCTAssertNil(coins, "Coins list should be nil")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testSuccessResponse() {
        // Swift 5 version
        // let json = #"{"id":"usd", "name": "US Dollar", "symbol": "$"}"#
        let json = "{\"id\":\"usd\", \"name\": \"US Dollar\", \"symbol\": \"$\"}"
        let object = try! Fiat.decoder.decode(Fiat.self, from: json.data(using: .utf8)!)
        let response = Result<Fiat, Error>.success(object)
        XCTAssert(response.value == object, "Response value should be equal \(object)")
        XCTAssertNil(response.error, "Response error should be empty")
        
        if case .success(let responseValue) = response {
            XCTAssert(responseValue == object, "Response value should be equal \(object)")
        } else {
            XCTFail("Response should be equal .success")
        }
    }
    
    func testFailureResponse() {
        let url = URL(string: "https://testapi.coinpaprika.com/")
        let error = ResponseError.emptyResponse(url: url)
        let response = Result<Fiat, Error>.failure(error)
        guard case .emptyResponse(let responseUrl) = (response.error as! ResponseError) else {
            XCTFail("Response error should be equal \(error)")
            return
        }
        
        XCTAssertNil(response.value, "Response value should be empty")
        XCTAssertEqual(responseUrl, url)
        
        guard case .failure(let responseError) = response, case .emptyResponse = (responseError as! ResponseError) else {
            XCTFail("Response should be equal .failure")
            return
        }
    }
    
    func testRequestError() {
        let expectation = self.expectation(description: "Waiting for ticker")
        
        Coinpaprika.API.ticker(id: "unexisting-coin-id", quotes: [.usd]).perform { (response) in
            let expectedCode = 404
            let expectedMessage = "id not found"
            
            XCTAssertNil(response.value, "Response value should be empty")
            let responseError = (response.error as? ResponseError)
            XCTAssertNotNil(responseError, "Response error shouldn't be empty")
            
            if case .invalidRequest(let code, let url, let message) = responseError! {
                XCTAssert(code == expectedCode, "Error code should be equal to \(expectedCode)")
                XCTAssertNotNil(url, "Response url should be not empty")
                XCTAssert(message == expectedMessage, "Error message should be equal to \(expectedMessage)")
            } else {
                XCTFail("Error should be equal to .invalidRequest with proper associated values")
            }
            
            expectation.fulfill()
        }
        
        
        waitForExpectations(timeout: 30)
    }
    
    func testExchangeRequest() {
        let expectation = self.expectation(description: "Waiting for exchange")
        
        Coinpaprika.API.exchange(id: binanceId, quotes: [.pln]).perform { (response) in
            let exchange = response.value
            XCTAssertNotNil(exchange, "Exchange should exist")
            
            XCTAssert((exchange?[.pln].adjustedVolume24h ?? 0) > 0, "Adjusted volume should be greater than 0")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }

    func testMarketRequest() {
        let expectation = self.expectation(description: "Waiting for exchange market")
        
        Coinpaprika.API.exchangeMarkets(id: binanceId).perform { (response) in
            let markets = response.value
            XCTAssertFalse(markets?.isEmpty ?? true, "Markets should exist")
            
            XCTAssert((markets?.first?[.usd].price ?? 0) > 0, "Price should be greater than 0")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testTickerHistoryRequest() {
        let expectation = self.expectation(description: "Waiting for ticker history")
        let limit = 5
        Coinpaprika.API.tickerHistory(id: bitcoinId, start: Date(timeIntervalSinceNow: -60*60*24), limit: limit, quote: .usd, interval: .minutes30).perform { (response) in
            let history = response.value
            XCTAssert(history?.count == limit, "Tickers lists count should be equal \(limit)")
            XCTAssert((history?.first?.price ?? 0) > 0, "Price should be greater than 0")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testCoinDetailsRequest() {
        let expectation = self.expectation(description: "Waiting for coin details")
        
        Coinpaprika.API.coin(id: bitcoinId).perform { (response) in
            let bitcoin = response.value
            
            XCTAssertNotNil(bitcoin, "Ticker should exist")
            XCTAssert(bitcoin?.id == self.bitcoinId, "BTC not found")
            XCTAssert(bitcoin?.symbol == "BTC", "BTC not found")
            
            XCTAssertNotNil(bitcoin?.whitepaper.link, "Whitepaper URL should exist")
            XCTAssertNotNil(bitcoin?.whitepaper.thumbnail, "Whitepaper Thumbnail should exist")
            
            XCTAssertNotNil(bitcoin?.team?.first, "Team should exist")
            
            XCTAssertNotNil(bitcoin?.description, "Description should exist")
            
            XCTAssertNotNil(bitcoin?.links.with(type: .sourceCode).first, "Source Code link should exist")
            
            XCTAssertNotNil(bitcoin?.links.with(type: .explorer).first, "Explorer link should exist")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testCoinExchangesRequest() {
        let expectation = self.expectation(description: "Waiting for exchanges")
        
        Coinpaprika.API.coinExchanges(id: bitcoinId).perform { (response) in
            let exchange = response.value?.first
            
            XCTAssertNotNil(exchange, "Exchange should exist")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testCoinMarketsRequest() {
        let expectation = self.expectation(description: "Waiting for exchange markets")
        
        Coinpaprika.API.coinMarkets(id: bitcoinId).perform { (response) in
            let markets = response.value
            XCTAssertFalse(markets?.isEmpty ?? true, "Markets should exist")
            
            XCTAssert((markets?.first?[.usd].price ?? 0) > 0, "Price should be greater than 0")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testPersonRequest() {
        let expectation = self.expectation(description: "Waiting for person details")
        
        Coinpaprika.API.person(id: satoshiId).perform { (response) in
            let person = response.value
            XCTAssertNotNil(person, "Person should exist")
            
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testEventsRequest() {
        let expectation = self.expectation(description: "Waiting for event details")
        
        Coinpaprika.API.coinEvents(id: bitcoinId).perform { (response) in
            let events = response.value
            XCTAssertNotNil(events?.first, "Event should exist")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testTweetsRequest() {
        let expectation = self.expectation(description: "Waiting for a list of tweets")
        
        Coinpaprika.API.coinTweets(id: bitcoinId).perform { (response) in
            let tweets = response.value
            XCTAssertNotNil(tweets?.first, "Tweet should exist")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testCoinLatestOhlcvRequest() {
        let expectation = self.expectation(description: "Waiting for a latest ohlcv")
        
        Coinpaprika.API.coinLatestOhlcv(id: bitcoinId).perform { (response) in
            let ohlcv = response.value
            XCTAssertNotNil(ohlcv?.first, "Ohlcv should exist")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testCoinHistoricalOhlcvRequest() {
        let expectation = self.expectation(description: "Waiting for a latest ohlcv")
        
        Coinpaprika.API.coinHistoricalOhlcv(id: bitcoinId, start: Date(timeIntervalSinceNow: -60*60*24)).perform { (response) in
            let ohlcv = response.value
            XCTAssertNotNil(ohlcv?.first, "Ohlcv should exist")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testFiatsRequest() {
        let expectation = self.expectation(description: "Waiting for a fiats list")
        
        Coinpaprika.API.fiats().perform { (response) in
            let fiats = response.value
            XCTAssertNotNil(fiats?.contains(where: { $0.symbol == "USD" }), "USD should exist")
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
}
