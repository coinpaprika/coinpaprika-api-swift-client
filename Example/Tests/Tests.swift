import XCTest
import CoinpaprikaAPI

class Tests: XCTestCase {
    
    let bitcoinId = "btc-bitcoin"
    
    func testGlobalStats() {
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
    
    func testCoins() {
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
    
    func testTickers() {
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
    
    func testTicker() {
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
    
}
