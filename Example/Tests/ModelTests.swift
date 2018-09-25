//
//  ModelTests.swift
//  CoinpaprikaAPI_Tests
//
//  Created by Dominique Stranz on 25/09/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import XCTest
import CoinpaprikaAPI

class ModelTests: XCTestCase {
    
    func testGlobalStatsModel() {
        let marketCapUsd = Int64.max
        let volume24hUsd = Int64.max
        let bitcoinDominancePercentage = Decimal(99.99)
        let cryptocurrenciesNumber = Int.max
        let lastUpdated = Date()
        
        let globalStats = GlobalStats(marketCapUsd: marketCapUsd, volume24hUsd: volume24hUsd, bitcoinDominancePercentage: bitcoinDominancePercentage, cryptocurrenciesNumber: cryptocurrenciesNumber, lastUpdated: lastUpdated)
        
        XCTAssertNotNil(globalStats)
        XCTAssert(globalStats.marketCapUsd == marketCapUsd)
        XCTAssert(globalStats.volume24hUsd == volume24hUsd)
        XCTAssert(globalStats.bitcoinDominancePercentage == bitcoinDominancePercentage)
        XCTAssert(globalStats.cryptocurrenciesNumber == cryptocurrenciesNumber)
        XCTAssert(globalStats.lastUpdated == lastUpdated)
    }
    
    func testCoinModel() {
        let id = "name-symbol"
        let name = "Name"
        let symbol = "code"
        
        let coin = Coin(id: id, name: name, symbol: symbol)
        
        XCTAssertNotNil(coin)
        XCTAssert(coin.id == id)
        XCTAssert(coin.name == name)
        XCTAssert(coin.symbol == symbol)
    }
    
    func testTickerModel() {
        let id = "name-symbol"
        let name = "Name"
        let symbol = "code"
        let rank = Int32.max
        let priceUsd = Decimal.greatestFiniteMagnitude
        let priceBtc = Decimal.greatestFiniteMagnitude
        let volume24hUsd = Int64.max
        let marketCapUsd = Int64.max
        let circulatingSupply = Int64.max
        let totalSupply = Int64.max
        let maxSupply = Int64.max
        let percentChange1h = Decimal(99.99)
        let percentChange24h = Decimal(99.99)
        let percentChange7d = Decimal(99.99)
        let lastUpdated = Date()
        
        let ticker = Ticker(id: id, name: name, symbol: symbol, rank: rank, priceUsd: priceUsd, priceBtc: priceBtc, volume24hUsd: volume24hUsd, marketCapUsd: marketCapUsd, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, percentChange1h: percentChange1h, percentChange24h: percentChange24h, percentChange7d: percentChange7d, lastUpdated: lastUpdated)
        
        XCTAssertNotNil(ticker)
        XCTAssert(ticker.id == id)
        XCTAssert(ticker.name == name)
        XCTAssert(ticker.rank == rank)
        XCTAssert(ticker.priceUsd == priceUsd)
        XCTAssert(ticker.priceBtc == priceBtc)
        XCTAssert(ticker.volume24hUsd == volume24hUsd)
        XCTAssert(ticker.marketCapUsd == marketCapUsd)
        XCTAssert(ticker.circulatingSupply == circulatingSupply)
        XCTAssert(ticker.totalSupply == totalSupply)
        XCTAssert(ticker.maxSupply == maxSupply)
        XCTAssert(ticker.percentChange1h == percentChange1h)
        XCTAssert(ticker.percentChange24h == percentChange24h)
        XCTAssert(ticker.percentChange7d == percentChange7d)
        XCTAssert(ticker.lastUpdated == lastUpdated)
    }
    
}

