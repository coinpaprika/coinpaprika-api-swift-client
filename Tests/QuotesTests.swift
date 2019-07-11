//
//  QuotesTests.swift
//  CoinpaprikaTests
//
//  Created by Dominique Stranz on 11/07/2019.
//

import XCTest
import Coinpaprika

class QuotesTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testQuoteSymbols() {
        /*
         Expected results generation
         QuoteCurrency.allCases.forEach({ (quote) in
         print("\"\(quote.rawValue)\": \"\(quote.symbol)\",")
         })
         */
        
        let expectedSymbols = ["BTC": "₿",
                               "ETH": "Ξ",
                               "USD": "$",
                               "EUR": "€",
                               "KRW": "₩",
                               "GBP": "£",
                               "CAD": "$",
                               "JPY": "¥",
                               "PLN": "zł",
                               "RUB": "₽",
                               "TRY": "₺",
                               "NZD": "$",
                               "AUD": "$",
                               "CHF": "CHF",
                               "UAH": "₴",
                               "HKD": "$",
                               "SGD": "$",
                               "NGN": "₦",
                               "PHP": "₱",
                               "MXN": "$",
                               "BRL": "R$",
                               "THB": "฿",
                               "CLP": "$",
                               "CNY": "¥",
                               "CZK": "Kč",
                               "DKK": "kr.",
                               "HUF": "Ft",
                               "IDR": "Rp",
                               "ILS": "₪",
                               "INR": "₹",
                               "MYR": "RM",
                               "NOK": "kr",
                               "PKR": "₨",
                               "SEK": "kr",
                               "TWD": "$",
                               "ZAR": "R",
                               "VND": "₫",
                               "BOB": "Bs.",
                               "COP": "$",
                               "PEN": "S/",
                               "ARS": "$",
                               "ISK": "kr"]
        
        for (code, symbol) in expectedSymbols {
            let quote = QuoteCurrency(rawValue: code)
            XCTAssertNotNil(quote)
            XCTAssertEqual(quote?.symbol, symbol)
        }
    }
    
}
