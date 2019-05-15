//
//  Coinpaprika.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

public typealias CoinpaprikaAPI = API

/// Coinpaprika API endpoints
public struct API {
    
    private static let baseUrl = URL(string: "https://api.coinpaprika.com/v1/")!
    
    /// Get global information
    ///
    /// - Returns: Request to perform
    public static func global() -> Request<GlobalStats> {
        return Request<GlobalStats>(baseUrl: baseUrl, method: .get, path: "global", params: nil)
    }
    
    /// Additional fields available in Tag response
    ///
    /// - coins: add this field if you want to match Coins with Tags
    public enum CoinsAdditionalFields: String, CaseIterable, QueryRepresentable {
        case imgRev = "img_rev"
        case contract
    }
    
    /// Get all coins listed on coinpaprika
    ///
    /// - Parameter additionalFields: list of additional fields that should be included in response, default: empty - see CoinsAdditionalFields for available options
    /// - Returns: Request to perform
    public static func coins(additionalFields: [CoinsAdditionalFields] = []) -> Request<[Coin]> {
        return Request<[Coin]>(baseUrl: baseUrl, method: .get, path: "coins", params: ["additional_fields": additionalFields.asCommaJoinedList])
    }
    
    /// Get coin details
    ///
    /// - Parameter id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func coin(id: String) -> Request<CoinExtended> {
        return Request<CoinExtended>(baseUrl: baseUrl, method: .get, path: "coins/\(id)", params: nil)
    }
    
    /// Get a list of exchanges where coin is listed
    ///
    /// - Parameter id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func coinExchanges(id: String) -> Request<[CoinExchange]> {
        return Request<[CoinExchange]>(baseUrl: baseUrl, method: .get, path: "coins/\(id)/exchanges", params: nil)
    }
    
    /// Get a list of markets where coin is available
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    ///   - quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func coinMarkets(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<[CoinMarket]> {
        return Request<[CoinMarket]>(baseUrl: baseUrl, method: .get, path: "coins/\(id)/markets", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Get a list of events related to this coin
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func coinEvents(id: String) -> Request<[Event]> {
        return Request<[Event]>(baseUrl: baseUrl, method: .get, path: "coins/\(id)/events", params: nil)
    }
    
    public static func createEvent(coinId: String, date: String, dateTo: String?, name: String, description: String?, isConference: Bool, link: URL, proofImageLink: URL?) -> Request<StatusResponse>  {
        var params: Request.Params = [
            "date": date,
            "name": name,
            "is_conference": isConference,
            "link": link.absoluteString
        ]
        
        if let dateTo = dateTo {
            params["date_to"] = dateTo
        }
        
        if let description = description {
            params["description"] = description
        }
        
        if let proofImageLink = proofImageLink {
            params["proof_image_link"] = proofImageLink.absoluteString
        }
        
        dump(params)
        return Request<StatusResponse>(baseUrl: baseUrl, method: .post, path: "coins/\(coinId)/events", params: params)
    }

    
    /// Get a list of tweets related to this coin
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func coinTweets(id: String) -> Request<[Tweet]> {
        return Request<[Tweet]>(baseUrl: baseUrl, method: .get, path: "coins/\(id)/twitter", params: nil)
    }
    
    /// Get ticker information for all coins
    ///
    /// - Parameter quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func tickers(quotes: [QuoteCurrency] = [.usd]) -> Request<[Ticker]> {
        return Request<[Ticker]>(baseUrl: baseUrl, method: .get, path: "tickers", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Get ticker information for specific coin
    ///
    /// - Parameters:
    ///    - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    ///    - quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func ticker(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<Ticker> {
        return Request<Ticker>(baseUrl: baseUrl, method: .get, path: "tickers/\(id)", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Search results scope
    public enum SearchCategory: String, CaseIterable, QueryRepresentable {
        /// Cryptocurrencies
        case currencies
        
        /// Crypto Exchanges
        case exchanges
        
        /// ICOs
        case icos
        
        /// People from projects
        case people
        
        /// Tags
        case tags
    }
    
    /// Search for currencies/icos/people/exchanges/tags
    ///
    /// - Parameters:
    ///   - query: phrase for search eg. btc
    ///   - categories: one or more categories (comma separated) to search, default .allCases - see SearchCategory for available options
    ///   - limit: limit of results per category, default 6 (max 250)
    /// - Returns: Request to perform
    public static func search(query: String, categories: [SearchCategory] = SearchCategory.allCases, limit: UInt = 6) -> Request<SearchResults> {
        return Request<SearchResults>(baseUrl: baseUrl, method: .get, path: "search", params: ["q": query, "c": categories.asCommaJoinedList, "limit": "\(limit)"])
    }
    
    /// Additional fields available in Tag response
    ///
    /// - coins: add this field if you want to match Coins with Tags
    public enum TagsAdditionalFields: String, CaseIterable, QueryRepresentable {
        case coins
    }

    /// Tags lists
    ///
    /// - Parameter additionalFields: list of additional fields that should be included in response, default: empty - see TagsAdditionalFields for available options
    /// - Returns: Request to perform
    public static func tags(additionalFields: [TagsAdditionalFields] = []) -> Request<[Tag]> {
        return Request<[Tag]>(baseUrl: baseUrl, method: .get, path: "tags", params: ["additional_fields": additionalFields.asCommaJoinedList])
    }
    
    /// Tag details
    ///
    /// - Parameters:
    ///   - id: tag identifier, like erc20
    ///   - additionalFields: list of additional fields that should be included in response, default: empty - see TagsAdditionalFields for available options
    /// - Returns: Request to perform
    public static func tag(id: String, additionalFields: [TagsAdditionalFields] = []) -> Request<Tag> {
        return Request<Tag>(baseUrl: baseUrl, method: .get, path: "tags/\(id)", params: ["additional_fields": additionalFields.asCommaJoinedList])
    }
    
    /// Exchanges list
    ///
    /// - Returns: Request to perform
    public static func exchanges(quotes: [QuoteCurrency] = [.usd]) -> Request<[Exchange]> {
        return Request<[Exchange]>(baseUrl: baseUrl, method: .get, path: "exchanges", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Exchange details
    ///
    /// - Parameters:
    ///   - id: exchange identifier, like binance
    ///   - quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func exchange(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<Exchange> {
        return Request<Exchange>(baseUrl: baseUrl, method: .get, path: "exchanges/\(id)", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Exchange markets
    ///
    /// - Parameters:
    ///   - id: exchange identifier, like binance
    ///   - quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func exchangeMarkets(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<[Market]> {
        return Request<[Market]>(baseUrl: baseUrl, method: .get, path: "exchanges/\(id)/markets", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Person details
    ///
    /// - Parameter id: person id eg. satoshi-nakamoto
    /// - Returns: Request to perform
    public static func person(id: String) -> Request<Person> {
        return Request<Person>(baseUrl: baseUrl, method: .get, path: "people/\(id)", params: nil)
    }
    
    /// Get a list of tweets related to this person
    ///
    /// - Parameters:
    ///   -  id: person id eg. satoshi-nakamoto
    /// - Returns: Request to perform
    public static func personTweets(id: String) -> Request<[Tweet]> {
        return Request<[Tweet]>(baseUrl: baseUrl, method: .get, path: "people/\(id)/twitter", params: nil)
    }
    
    private static func validateTickerHistoryQuote(_ quote: QuoteCurrency) {
        let acceptedQuotes: [QuoteCurrency] = [.usd, .btc]
        assert(acceptedQuotes.contains(quote), "This endpoint accepts only \(acceptedQuotes).")
    }
    
    private static func validateTickerHistoryLimit(_ limit: Int) {
        let min = 1
        let max = 5000
        assert(min >= min && max <= max, "Limit should be between \(min) and \(max).")
    }
    
    /// Intervals for historical data endpoint
    public enum TickerHistoryInterval: String, CaseIterable {
        /// 5 minutes interval
        case minutes5 = "5m"
        
        /// 10 minutes interval
        case minutes10 = "10m"
        
        /// 15 minutes interval
        case minutes15 = "15m"
        
        /// 30 minutes interval
        case minutes30 = "30m"
        
        /// 45 minutes interval
        case minutes45 = "45m"
        
        /// 1 hour interval
        case hours1 = "1h"
        
        /// 2 hours interval
        case hours2 = "2h"
        
        /// 3 hours interval
        case hours3 = "3h"
        
        /// 6 hours interval
        case hours6 = "6h"
        
        /// 12 hours interval
        case hours12 = "12h"
        
        /// 24 hours interval
        case hours24 = "24h"
        
        /// 1 day interval
        case days1 = "1d"
        
        /// 7 days interval
        case days7 = "7d"
        
        /// 14 days interval
        case days14 = "14d"
        
        /// 30 days interval
        case days30 = "30d"
        
        /// 90 days interval
        case days90 = "90d"
        
        /// 365 days interval
        case days365 = "365d"
    }
    
    
    /// Get historical ticker information for specific coin
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    ///   - start: Start date, required
    ///   - end: End date, default .now
    ///   - limit: Returns limit, default 1000, max 5000
    ///   - quote: requested quote, default .usd
    ///   - interval: data interval, default 5 minutes .minutes5
    /// - Returns: Request to perform
    public static func tickerHistory(id: String, start: Date, end: Date = Date(), limit: Int = 1000, quote: QuoteCurrency = .usd, interval: TickerHistoryInterval = .minutes5) -> Request<[TickerHistory]> {
        validateTickerHistoryQuote(quote)
        validateTickerHistoryLimit(limit)
        return Request<[TickerHistory]>(baseUrl: baseUrl, method: .get, path: "tickers/\(id)/historical", params: ["start": "\(Int(start.timeIntervalSince1970))", "end": "\(Int(end.timeIntervalSince1970))", "limit": "\(limit)", "quote": quote.rawValue, "interval": interval.rawValue])
    }
    
    private static func validateCoinOhlcvQuote(_ quote: QuoteCurrency) {
        let acceptedQuotes: [QuoteCurrency] = [.usd, .btc]
        assert(acceptedQuotes.contains(quote), "This endpoint accepts only \(acceptedQuotes).")
    }
    
    private static func validateCoinOhlcvLimit(_ limit: Int) {
        let min = 1
        let max = 366
        assert(min >= min && max <= max, "Limit should be between \(min) and \(max).")
    }
    
    /// Latest Open/High/Low/Close values with volume and market_cap
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func coinLatestOhlcv(id: String, quote: QuoteCurrency = .usd) -> Request<[Ohlcv]> {
        validateCoinOhlcvQuote(quote)
        return Request<[Ohlcv]>(baseUrl: baseUrl, method: .get, path: "/coins/\(id)/ohlcv/latest", params: ["query": quote.rawValue])
    }

    /// Historical Open/High/Low/Close values with volume and market_cap
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    ///   - start: Start date, required
    ///   - end: End date, if not provided calculated by the limit parameter
    ///   - limit: Returns limit, default 1, max 366
    ///   - quote: requested quote, default .usd
    /// - Returns: Request to perform
    public static func coinHistoricalOhlcv(id: String, start: Date, end: Date? = nil, limit: Int = 1, quote: QuoteCurrency = .usd) -> Request<[Ohlcv]> {
        validateCoinOhlcvQuote(quote)
        validateCoinOhlcvLimit(limit)
        
        var params = ["start": "\(Int(start.timeIntervalSince1970))", "limit": "\(limit)", "quote": quote.rawValue]
        
        if let end = end {
            params["end"] = "\(Int(end.timeIntervalSince1970))"
        }
        
        return Request<[Ohlcv]>(baseUrl: baseUrl, method: .get, path: "/coins/\(id)/ohlcv/historical", params: params)
    }
    
    /// Latest News
    ///
    /// - Parameters:
    ///   - limit: Returns limit, default 3
    /// - Returns: Request to perform
    public static func latestNews(limit: Int = 3) -> Request<[News]> {
        return Request<[News]>(baseUrl: baseUrl, method: .get, path: "news/latest", params: ["limit": limit])
    }
    
    /// Historical News
    ///
    /// - Parameters:
    ///   - start: Start date, required
    ///   - end: End date, if not provided returns news from 1 day, max period 30 days
    /// - Returns: Request to perform
    public static func historicalNews(start: Date, end: Date? = nil) -> Request<[News]> {
        var params = ["start": "\(Int(start.timeIntervalSince1970))"]
        
        if let end = end {
            params["end"] = "\(Int(end.timeIntervalSince1970))"
        }
        
        return Request<[News]>(baseUrl: baseUrl, method: .get, path: "news/latest", params: params)
    }
    
    /// Type for Top Movers endpoint
    public enum TopMoversType: String, CaseIterable {
        /// Top Movers by price change
        case price
        
        /// Top Movers by volume change
        case volume
    }
    
    /// Time range for Top Movers endpoint
    public enum TopMoversTimeRange: String, CaseIterable {
        /// Top Movers from last 24 hours
        case day = "24h"
        
        /// Top Movers from last 7 days
        case week = "7d"
    }
    
    /// Market cap limit for Top Movers endpoint
    public enum TopMoversLimit: String, CaseIterable {
        /// Top Movers from top 200 coins (by market cap)
        case top200
        
        /// Top Movers from top 300 coins (by market cap)
        case top300
        
        /// Top Movers from all coins
        case all
    }
    
    private static func validateTopMoversQuote(_ quote: QuoteCurrency) {
        let acceptedQuotes: [QuoteCurrency] = [.usd, .btc]
        assert(acceptedQuotes.contains(quote), "This endpoint accepts only \(acceptedQuotes).")
    }
    
    /// Top Movers Ranking - Gainers & Losers
    ///
    /// - Parameters:
    ///   - type: Metric used in ranking - .price or .volume, default .price
    ///   - range: Time range - .day or .week, default .day
    ///   - limit: Coins market cap limit used in ranking - .top200 or .all, default .all
    ///   - quote: Quote currency - .usd or .btc, default .usd
    ///   - resultsNumber: Results number, default 10
    /// - Returns: Request to perform
    public static func topMovers(type: TopMoversType = .price, range: TopMoversTimeRange = .day, limit: TopMoversLimit = .all, quote: QuoteCurrency = .usd, resultsNumber: Int = 10) -> Request<TopMovers> {
        validateTopMoversQuote(quote)
        return Request<TopMovers>(baseUrl: baseUrl, method: .get, path: "rankings/top-movers", params: ["type": type.rawValue, "time_range": range.rawValue, "marketcap_limit": limit.rawValue, "quote": quote.rawValue, "results_number": resultsNumber])
    }
    
    /// List of available Fiat's currencies - accepted as quotes by tickers, exchanges, markets endpoints.
    ///
    /// - Returns: Request to perform
    public static func fiats() -> Request<[Fiat]> {
        return Request<[Fiat]>(baseUrl: baseUrl, method: .get, path: "fiats", params: nil)
    }
}
