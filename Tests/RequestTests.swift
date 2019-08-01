//
//  RequestTests.swift
//  CoinpaprikaAPI_Tests
//
//  Created by Dominique Stranz on 25/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
@testable import Coinpaprika
import Networking
import NetworkingMocks

class RequestTests: XCTestCase {
    
    let bitcoinId = "btc-bitcoin"
    let satoshiId = "satoshi-nakamoto"
    let binanceId = "binance"
    
    func testGlobalStatsRequest() {
        let expectation = self.expectation(description: "Waiting for global stats")
        
        let expectedModel = GlobalStats(marketCapUsd: 3560740,
                                        marketCapAthValue: 835692000000,
                                        marketCapAthDate: Date(timeIntervalSince1970: 1562762622),
                                        marketCapChange24h: 3.15,
                                        volume24hUsd: 709313,
                                        volume24hAthValue: 131881,
                                        volume24hAthDate: Date(timeIntervalSince1970: 1562762622),
                                        volume24hChange24h: -4.22,
                                        bitcoinDominancePercentage: 65.14,
                                        cryptocurrenciesNumber: 2554)
        
        Coinpaprika.API.global().perform(session: CodableMock(expectedModel)) { (response) in
            let stats = response.value
            XCTAssertNotNil(stats)
            
            XCTAssertEqual(stats?.marketCapUsd, expectedModel.marketCapUsd)
            XCTAssertEqual(stats?.marketCapAthValue, expectedModel.marketCapAthValue)
            XCTAssertEqual(stats?.marketCapAthDate, expectedModel.marketCapAthDate)
            XCTAssertEqual(stats?.marketCapChange24h, expectedModel.marketCapChange24h)
            XCTAssertEqual(stats?.volume24hUsd, expectedModel.volume24hUsd)
            XCTAssertEqual(stats?.volume24hAthValue, expectedModel.volume24hAthValue)
            XCTAssertEqual(stats?.volume24hAthDate, expectedModel.volume24hAthDate)
            XCTAssertEqual(stats?.volume24hChange24h, expectedModel.volume24hChange24h)
            XCTAssertEqual(stats?.bitcoinDominancePercentage, expectedModel.bitcoinDominancePercentage)
            XCTAssertEqual(stats?.cryptocurrenciesNumber, expectedModel.cryptocurrenciesNumber)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testCoinsRequest() {
        let expectation = self.expectation(description: "Waiting for coins")
        
        let expectedModel: [Coin] = [Coin(id: "btc-bitcoin",
                                          name: "Bitcoin",
                                          symbol: "BTC",
                                          rank: 1,
                                          isNew: false,
                                          isActive: true,
                                          typeStorage: .coin),
                                     Coin(id: "tusd-trueusd",
                                          name: "TrueUSD",
                                          symbol: "tusd",
                                          rank: 99,
                                          isNew: true,
                                          isActive: false,
                                          typeStorage: .token)]
        
        Coinpaprika.API.coins().perform(session: CodableMock(expectedModel)) { (response) in
            let coins = response.value
            XCTAssertNotNil(coins)
            
            for (index, coin) in coins!.enumerated() {
                XCTAssertEqual(coin.id, expectedModel[index].id)
                XCTAssertEqual(coin.name, expectedModel[index].name)
                XCTAssertEqual(coin.rank, expectedModel[index].rank)
                XCTAssertEqual(coin.isNew, expectedModel[index].isNew)
                XCTAssertEqual(coin.isActive, expectedModel[index].isActive)
                XCTAssertEqual(coin.type, expectedModel[index].type)
                XCTAssertEqual(coin.imgRev, expectedModel[index].imgRev)
                XCTAssertEqual(coin.contract, expectedModel[index].contract)
            }
            
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
            XCTAssert((markets?.first?[.usd].volume24h ?? 0) > 0, "Volume24h should be greater than 0")
            
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
        
        let jsonResponse = """
{"id":"eth-ethereum","name":"Ethereum","symbol":"ETH","rank":2,"is_new":false,"is_active":true,"type":"coin","tags":[{"id":"token-issuance","name":"Token Issuance","coin_counter":73,"ico_counter":24},{"id":"decentralized-applications","name":"Decentralized Applications","coin_counter":106,"ico_counter":38},{"id":"proof-of-work","name":"Proof Of Work","coin_counter":494,"ico_counter":14},{"id":"smart-contracts","name":"Smart Contracts","coin_counter":649,"ico_counter":304}],"team":[{"id":"vitalik-buterin","name":"Vitalik Buterin","position":"Author"},{"id":"jeffrey-wylcke","name":"Jeffrey Wylcke","position":"Go-Ethereum Lead"},{"id":"virgil-griffith","name":"Virgil Griffith","position":"Researcher"},{"id":"alexandre-van-de-sande","name":"Alexandre Van de Sande","position":"UX Design"},{"id":"alex-leverington","name":"Alex Leverington","position":"Core Developer"},{"id":"aya-miyaguchi","name":"Aya Miyaguchi","position":"Executive Director"},{"id":"vlad-zamfir","name":"Vlad Zamfir","position":"Researcher"},{"id":"zach-lebeau","name":"Zach Lebeau","position":"Conceptualist"},{"id":"justin-drake","name":"Justin Drake","position":"Researcher"},{"id":"yoichi-hirai","name":"Yoichi Hirai","position":"Formal Verification Engineer"},{"id":"iuri-matias","name":"Iuri Matias","position":"Developer"},{"id":"karl-floersch","name":"Karl Floersch","position":"Researcher"}],"description":"Ethereum is a decentralized platform for applications. Applications build on it can use smart contracts - computer algorithms which execute themselves when data is supplied to the platform. There is no need for any human operators.","message":"","open_source":true,"started_at":"2015-07-30T00:00:00Z","development_status":"Working product","hardware_wallet":true,"proof_type":"Ethereum consensus (currently proof of work, will be proof of stake later on)","org_structure":"Semi-centralized","hash_algorithm":"Ethash","links":{"explorer":["https://etherscan.io/","https://ethplorer.io/","https://etherchain.org/","https://blockchair.com/ethereum"],"facebook":["https://www.facebook.com/ethereumproject/"],"reddit":["https://www.reddit.com/r/ethereum"],"source_code":["https://github.com/ethereum/go-ethereum"],"website":["https://www.ethereum.org/"],"youtube":["https://www.youtube.com/watch?v=TDGq4aeevgY"]},"links_extended":[{"url":"https://bitcointalk.org/index.php?topic=428589.0","type":"announcement"},{"url":"https://blog.ethereum.org/","type":"blog"},{"url":"https://gitter.im/orgs/ethereum/rooms","type":"chat"},{"url":"https://blockchair.com/ethereum","type":"explorer"},{"url":"https://etherscan.io/","type":"explorer"},{"url":"https://ethplorer.io/","type":"explorer"},{"url":"https://etherchain.org/","type":"explorer"},{"url":"https://www.facebook.com/ethereumproject/","type":"facebook"},{"url":"https://forum.ethereum.org/","type":"message_board"},{"url":"https://www.reddit.com/r/ethereum","type":"reddit","stats":{"subscribers":442074}},{"url":"https://github.com/ethereum/go-ethereum","type":"source_code","stats":{"contributors":447,"stars":23783}},{"url":"https://twitter.com/ethereum","type":"twitter","stats":{"followers":445752}},{"url":"https://github.com/ethereum/mist/releases","type":"wallet"},{"url":"https://www.ethereum.org/","type":"website"},{"url":"https://www.youtube.com/watch?v=TDGq4aeevgY","type":"youtube"}],"whitepaper":{"link":"https://github.com/ethereum/wiki/wiki/White-Paper","thumbnail":"https://static.coinpaprika.com/storage/cdn/whitepapers/1689.jpg"},"first_data_at":"2015-08-07T00:00:00Z","last_data_at":"2019-07-11T10:20:00Z"}
"""
        
        Coinpaprika.API.coin(id: bitcoinId).perform(session: JsonMock(jsonResponse)) { (response) in
            let coin = response.value
            
            XCTAssertNotNil(coin, "Ticker should exist")
            XCTAssertEqual(coin?.id, "eth-ethereum")
            XCTAssertEqual(coin?.name, "Ethereum")
            XCTAssertEqual(coin?.symbol, "ETH")
            XCTAssertEqual(coin?.rank, 2)
            XCTAssertEqual(coin?.type, .coin)
            
            let tagId = "proof-of-work"
            let tag = coin?.tags?.first(where: { $0.id == tagId })
            XCTAssertEqual(tag?.id, tagId)
            XCTAssertEqual(tag?.name, "Proof Of Work")
            XCTAssertEqual(tag?.coinCounter, 494)
            XCTAssertEqual(tag?.icoCounter, 14)
            
            XCTAssertNotNil(coin?.description)
            
            XCTAssertEqual(coin?.whitepaper.link?.absoluteString, "https://github.com/ethereum/wiki/wiki/White-Paper")
            
            XCTAssertEqual(coin?.links.with(type: .explorer).first?.url.absoluteString, "https://blockchair.com/ethereum")
            XCTAssertEqual(coin?.links.with(type: .sourceCode).first?.contributors, 447)
            XCTAssertEqual(coin?.links.with(type: .sourceCode).first?.stars, 23783)
            
            XCTAssertEqual(coin?.links.explorer, coin?.links.with(type: .explorer).map({ $0.url }))
            XCTAssertEqual(coin?.links.website, coin?.links.with(type: .website).map({ $0.url }))
            XCTAssertEqual(coin?.links.facebook, coin?.links.with(type: .facebook).map({ $0.url }))
            XCTAssertEqual(coin?.links.twitter, coin?.links.with(type: .twitter).map({ $0.url }))
            XCTAssertEqual(coin?.links.reddit, coin?.links.with(type: .reddit).map({ $0.url }))
            XCTAssertEqual(coin?.links.youtube, coin?.links.with(type: .youtube).map({ $0.url }))
            XCTAssertEqual(coin?.links.vimeo, coin?.links.with(type: .vimeo).map({ $0.url }))
            XCTAssertEqual(coin?.links.videoFile, coin?.links.with(type: .videoFile).map({ $0.url }))
            
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
        
        let expectedModel = [Fiat(id: "usd-us-dollars", name: "US Dollars", symbol: "USD")]
        
        Coinpaprika.API.fiats().perform(session: CodableMock(expectedModel)) { (response) in
            let fiats = response.value
            for (index, fiat) in fiats!.enumerated() {
                XCTAssertEqual(fiat.id, expectedModel[index].id)
                XCTAssertEqual(fiat.name, expectedModel[index].name)
                XCTAssertEqual(fiat.symbol, expectedModel[index].symbol)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testTweetRequest() {
        
        let expectation = self.expectation(description: "Waiting for API")
        
        let expectedModel = [Tweet(id: "1145701967769067520", status: "Tweet text", userName: "Username", isRetweet: false, date: Date(timeIntervalSince1970: 1562762622), statusLink: URL(string: "https://twitter.com/ethereum/status/1145701967769067520")!, mediaLink: URL(string: "https://pbs.twimg.com/media/image.jpg"), videoLink: URL(string: "https://pbs.twimg.com/media/video.mp4"), userImageLink: URL(string: "http://pbs.twimg.com/profile_images/avatar.png"), retweeetCount: 10, likeCount: 20)]
        
        Coinpaprika.API.coinTweets(id: "eth-ethereum").perform(session: CodableMock(expectedModel)) { (response) in
            let tweets = response.value
            for (index, tweet) in tweets!.enumerated() {
                XCTAssertEqual(tweet.id, expectedModel[index].id)
                XCTAssertEqual(tweet.status, expectedModel[index].status)
                XCTAssertEqual(tweet.userName, expectedModel[index].userName)
                XCTAssertEqual(tweet.isRetweet, expectedModel[index].isRetweet)
                XCTAssertEqual(tweet.date, expectedModel[index].date)
                XCTAssertEqual(tweet.statusLink, expectedModel[index].statusLink)
                XCTAssertEqual(tweet.mediaLink, expectedModel[index].mediaLink)
                XCTAssertEqual(tweet.videoLink, expectedModel[index].videoLink)
                XCTAssertEqual(tweet.userImageLink, expectedModel[index].userImageLink)
                XCTAssertEqual(tweet.retweeetCount, expectedModel[index].retweeetCount)
                XCTAssertEqual(tweet.likeCount, expectedModel[index].likeCount)
                XCTAssertEqual(tweet.imageLink, expectedModel[index].mediaLink)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testRequestLimitExceeded() {
        let expectation = self.expectation(description: "Waiting for API")
        Coinpaprika.API.global().perform(session: JsonMock("[]", statusCode: 429)) { (response) in
            if case .requestsLimitExceeded(let url) = response.error as? ResponseError {
                XCTAssertNotNil(url)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testRequestErrorMessage() {
        let expectation = self.expectation(description: "Waiting for API")
        let errorMessage = "Test Error"
        let errorCode = 401
        Coinpaprika.API.global().perform(session: JsonMock("{\"error\": \"\(errorMessage)\"}", statusCode: errorCode)) { (response) in
            if case .invalidRequest(let httpCode, let url, let message) = response.error as? ResponseError {
                XCTAssertEqual(httpCode, errorCode)
                XCTAssertEqual(message, errorMessage)
                XCTAssertNotNil(url)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
    
    func testServerErrorMessage() {
        let expectation = self.expectation(description: "Waiting for API")
        let errorCode = 500
        Coinpaprika.API.global().perform(session: JsonMock("[]", statusCode: errorCode)) { (response) in
            if case .serverError(let httpCode, let url) = response.error as? ResponseError {
                XCTAssertEqual(httpCode, errorCode)
                XCTAssertNotNil(url)
            } else {
                XCTFail()
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 30)
    }
}
