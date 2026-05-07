//
//  Coinpaprika.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation
#if canImport(CoinpaprikaNetworking)
import CoinpaprikaNetworking
#endif

public typealias CoinpaprikaAPI = API

/// Coinpaprika API endpoints
public struct API {
    
    /// Get global information
    ///
    /// - Returns: Request to perform
    public static func global() -> Request<GlobalStats> {
        return request(method: .get, path: "global", params: nil)
    }
    
    /// Additional fields available in Tag response
    ///
    /// - coins: add this field if you want to match Coins with Tags
    public enum CoinsAdditionalFields: String, CaseIterable, QueryRepresentable {
        case imgRev = "img_rev"
        case contract
        case contracts
    }
    
    /// Get all coins listed on coinpaprika
    ///
    /// - Parameter additionalFields: list of additional fields that should be included in response, default: empty - see CoinsAdditionalFields for available options
    /// - Returns: Request to perform
    public static func coins(additionalFields: [CoinsAdditionalFields] = []) -> Request<[Coin]> {
        return request(method: .get, path: "coins", params: ["additional_fields": additionalFields.asCommaJoinedList])
    }
    
    /// Get coin details
    ///
    /// - Parameter id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func coin(id: String) -> Request<CoinExtended> {
        return request(method: .get, path: "coins/\(id)", params: nil)
    }
    
    /// Get a list of exchanges where coin is listed
    ///
    /// - Parameter id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func coinExchanges(id: String) -> Request<[CoinExchange]> {
        return request(method: .get, path: "coins/\(id)/exchanges", params: nil)
    }
    
    /// Get a list of markets where coin is available
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    ///   - quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func coinMarkets(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<[CoinMarket]> {
        return request(method: .get, path: "coins/\(id)/markets", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Get a list of events related to this coin
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func coinEvents(id: String) -> Request<[Event]> {
        return request(method: .get, path: "coins/\(id)/events", params: nil)
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
        
        return request(method: .post, path: "coins/\(coinId)/events", params: params)
    }

    
    /// Get a list of tweets related to this coin
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    /// - Returns: Request to perform
    public static func coinTweets(id: String) -> Request<[Tweet]> {
        return request(method: .get, path: "coins/\(id)/twitter", params: nil)
    }
    
    /// Get ticker information for all coins
    ///
    /// - Parameter quotes: list of requested quotes, default [.usd]
    /// - Parameter page: when specified, returns only a subset of the list of tickers (first page has a corresponding value of 1)
    /// - Returns: Request to perform
    public static func tickers(quotes: [QuoteCurrency] = [.usd], page: Int? = nil) -> Request<[Ticker]> {
        var params: Request.Params = ["quotes": quotes.asCommaJoinedList]
        params["page"] = page
        return request(method: .get, path: "tickers", params: params)
    }
    
    /// Get ticker information for specific coin
    ///
    /// - Parameters:
    ///    - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    ///    - quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func ticker(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<Ticker> {
        return request(method: .get, path: "tickers/\(id)", params: ["quotes": quotes.asCommaJoinedList])
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
    
    /// Modifier value for the `search` endpoint.
    ///
    /// Wraps the raw API string so callers can use `.symbolSearch` for type safety
    /// while still being able to pass any future server-side modifier value via
    /// `SearchModifier(rawValue:)`.
    public struct SearchModifier: Equatable, RawRepresentable {
        public let rawValue: String

        public init(rawValue: String) {
            self.rawValue = rawValue
        }

        /// Search by symbol only (works for currencies only).
        public static let symbolSearch = SearchModifier(rawValue: "symbol_search")
    }

    /// Search for currencies/icos/people/exchanges/tags
    ///
    /// - Parameters:
    ///   - query: phrase for search eg. btc
    ///   - categories: one or more categories (comma separated) to search, default .allCases - see SearchCategory for available options
    ///   - modifier: optional search modifier, eg. `.symbolSearch` to match by symbol only. Default nil (no modifier)
    ///   - limit: limit of results per category, default 6 (max 250)
    /// - Returns: Request to perform
    public static func search(query: String, categories: [SearchCategory] = SearchCategory.allCases, modifier: SearchModifier? = nil, limit: UInt = 6) -> Request<SearchResults> {
        var params: Request<SearchResults>.Params = [
            "q": query,
            "c": categories.asCommaJoinedList,
            "limit": "\(limit)"
        ]
        if let modifier = modifier {
            params["modifier"] = modifier.rawValue
        }
        return request(method: .get, path: "search", params: params)
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
        return request(method: .get, path: "tags", params: ["additional_fields": additionalFields.asCommaJoinedList])
    }
    
    /// Tag details
    ///
    /// - Parameters:
    ///   - id: tag identifier, like erc20
    ///   - additionalFields: list of additional fields that should be included in response, default: empty - see TagsAdditionalFields for available options
    /// - Returns: Request to perform
    public static func tag(id: String, additionalFields: [TagsAdditionalFields] = []) -> Request<Tag> {
        return request(method: .get, path: "tags/\(id)", params: ["additional_fields": additionalFields.asCommaJoinedList])
    }
    
    /// Exchanges list
    ///
    /// - Returns: Request to perform
    public static func exchanges(quotes: [QuoteCurrency] = [.usd]) -> Request<[Exchange]> {
        return request(method: .get, path: "exchanges", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Exchange details
    ///
    /// - Parameters:
    ///   - id: exchange identifier, like binance
    ///   - quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func exchange(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<Exchange> {
        return request(method: .get, path: "exchanges/\(id)", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Exchange markets
    ///
    /// - Parameters:
    ///   - id: exchange identifier, like binance
    ///   - quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func exchangeMarkets(id: String, quotes: [QuoteCurrency] = [.usd]) -> Request<[Market]> {
        return request(method: .get, path: "exchanges/\(id)/markets", params: ["quotes": quotes.asCommaJoinedList])
    }
    
    /// Person details
    ///
    /// - Parameter id: person id eg. satoshi-nakamoto
    /// - Returns: Request to perform
    public static func person(id: String) -> Request<Person> {
        return request(method: .get, path: "people/\(id)", params: nil)
    }
    
    /// Get a list of tweets related to this person
    ///
    /// - Parameters:
    ///   -  id: person id eg. satoshi-nakamoto
    /// - Returns: Request to perform
    public static func personTweets(id: String) -> Request<[Tweet]> {
        return request(method: .get, path: "people/\(id)/twitter", params: nil)
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
        return request(method: .get, path: "tickers/\(id)/historical", params: ["start": "\(Int(start.timeIntervalSince1970))", "end": "\(Int(end.timeIntervalSince1970))", "limit": "\(limit)", "quote": quote.rawValue, "interval": interval.rawValue])
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
        // /coins/{id}/ohlcv/latest is case-sensitive on `quote`: uppercase
        // returns 400 invalid parameters. Other endpoints (`tickers?quotes=`,
        // `ohlcv/historical?quote=`) accept both cases.
        return request(method: .get, path: "coins/\(id)/ohlcv/latest", params: ["quote": quote.rawValue.lowercased()])
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
        
        return request(method: .get, path: "coins/\(id)/ohlcv/historical", params: params)
    }
    
    /// Latest News
    ///
    /// - Parameters:
    ///   - limit: Returns limit, default 3
    /// - Returns: Request to perform
    public static func latestNews(limit: Int = 3) -> Request<[News]> {
        return request(method: .get, path: "news/latest", params: ["limit": limit])
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
        
        return request(method: .get, path: "news/historical", params: params)
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
        return request(method: .get, path: "rankings/top-movers", params: ["type": type.rawValue, "time_range": range.rawValue, "marketcap_limit": limit.rawValue, "quote": quote.rawValue, "results_number": resultsNumber])
    }
    
    /// List of available Fiat's currencies - accepted as quotes by tickers, exchanges, markets endpoints.
    ///
    /// - Returns: Request to perform
    public static func fiats() -> Request<[Fiat]> {
        return request(method: .get, path: "fiats", params: nil)
    }

    /// API key information including plan and monthly usage. Requires `Configuration.apiKey` set.
    ///
    /// - Returns: Request to perform
    public static func keyInfo() -> Request<KeyInfo> {
        return request(method: .get, path: "key/info", params: nil)
    }

    /// Latest 24-hour OHLCV (Open/High/Low/Close + volume + market cap) for a coin.
    ///
    /// - Parameters:
    ///   - id: ID of coin to return e.g. btc-bitcoin, eth-ethereum
    ///   - quote: requested quote, default .usd
    /// - Returns: Request to perform
    public static func coinTodayOhlcv(id: String, quote: QuoteCurrency = .usd) -> Request<[Ohlcv]> {
        validateCoinOhlcvQuote(quote)
        // Same case sensitivity quirk as `coinLatestOhlcv`: quote must be lowercase.
        return request(method: .get, path: "coins/\(id)/ohlcv/today", params: ["quote": quote.rawValue.lowercased()])
    }

    /// Provider used to look up an ID mapping via `/coins/mappings`.
    ///
    /// The API requires exactly one provider per request; passing more than one
    /// returns 400 invalid parameters. The enum makes that constraint unrepresentable.
    public enum MappingProvider {
        /// Coinpaprika ID, eg. `btc-bitcoin`.
        case coinpaprika(String)
        /// Coinmarketcap numeric ID as a string.
        case coinmarketcap(String)
        /// CoinGecko ID, eg. `bitcoin`.
        case coingecko(String)
        /// Cryptocompare numeric ID as a string.
        case cryptocompare(String)
        /// International Securities Identification Number.
        case isin(String)
        /// Digital Token Identifier.
        case dti(String)

        var queryItem: (name: String, value: String) {
            switch self {
            case .coinpaprika(let v):   return ("coinpaprika", v)
            case .coinmarketcap(let v): return ("coinmarketcap", v)
            case .coingecko(let v):     return ("coingecko", v)
            case .cryptocompare(let v): return ("cryptocompare", v)
            case .isin(let v):          return ("isin", v)
            case .dti(let v):           return ("dti", v)
            }
        }
    }

    /// Look up a coin id mapping between Coinpaprika and another provider
    /// (CoinGecko, CoinMarketCap, Cryptocompare, ISIN, DTI). Requires Business plan or higher.
    ///
    /// Exactly one provider must be supplied; the API rejects multi-provider queries.
    ///
    /// - Parameter provider: provider/id pair to resolve, eg. `.coingecko("bitcoin")`
    /// - Returns: Request to perform
    public static func coinMappings(by provider: MappingProvider) -> Request<CoinMapping> {
        let item = provider.queryItem
        return request(method: .get, path: "coins/mappings", params: [item.name: item.value])
    }

    /// List of contract platform ids (eg. eth-ethereum, bsc-binance-smart-chain).
    ///
    /// - Returns: Request to perform
    public static func contractPlatforms() -> Request<[String]> {
        return request(method: .get, path: "contracts", params: nil)
    }

    /// All token contracts on a given platform.
    ///
    /// - Parameter platformId: platform id, eg. eth-ethereum
    /// - Returns: Request to perform
    public static func contracts(platformId: String) -> Request<[Contract]> {
        return request(method: .get, path: "contracts/\(platformId)", params: nil)
    }

    /// Ticker for a token by its contract address. Server returns a 301 redirect to
    /// `/tickers/{coin_id}`; URLSession follows it transparently.
    ///
    /// - Parameters:
    ///   - platformId: platform id, eg. eth-ethereum
    ///   - address: contract address
    ///   - quotes: list of requested quotes, default [.usd]
    /// - Returns: Request to perform
    public static func tickerByContract(platformId: String, address: String, quotes: [QuoteCurrency] = [.usd]) -> Request<Ticker> {
        return request(method: .get, path: "contracts/\(platformId)/\(address)", params: ["quotes": quotes.asCommaJoinedList])
    }

    /// Historical ticker data for a token by its contract address. Server returns a 301 redirect
    /// to `/tickers/{coin_id}/historical`; URLSession follows it transparently.
    ///
    /// - Parameters:
    ///   - platformId: platform id, eg. eth-ethereum
    ///   - address: contract address
    ///   - start: Start date, required
    ///   - end: End date, default .now
    ///   - limit: Returns limit, default 1000, max 5000
    ///   - quote: requested quote, default .usd
    ///   - interval: data interval, default 5 minutes .minutes5
    /// - Returns: Request to perform
    public static func tickerHistoryByContract(platformId: String, address: String, start: Date, end: Date = Date(), limit: Int = 1000, quote: QuoteCurrency = .usd, interval: TickerHistoryInterval = .minutes5) -> Request<[TickerHistory]> {
        validateTickerHistoryQuote(quote)
        validateTickerHistoryLimit(limit)
        return request(method: .get, path: "contracts/\(platformId)/\(address)/historical", params: ["start": "\(Int(start.timeIntervalSince1970))", "end": "\(Int(end.timeIntervalSince1970))", "limit": "\(limit)", "quote": quote.rawValue, "interval": interval.rawValue])
    }

    /// Recent coin id changes from the Coinpaprika changelog. Requires Starter plan or higher.
    ///
    /// - Parameter page: optional page number for paginated results
    /// - Returns: Request to perform
    public static func changelogIds(page: Int? = nil) -> Request<[ChangelogEntry]> {
        var params: [String: Any] = [:]
        if let page = page {
            params["page"] = page
        }
        return request(method: .get, path: "changelog/ids", params: params.isEmpty ? nil : params)
    }

    /// Convert an amount of one currency into another using current prices.
    ///
    /// - Parameters:
    ///   - baseCurrencyId: source currency id, eg. btc-bitcoin
    ///   - quoteCurrencyId: target currency id, eg. usd-us-dollars
    ///   - amount: amount to convert, default 1
    /// - Returns: Request to perform
    public static func priceConvert(baseCurrencyId: String, quoteCurrencyId: String, amount: Decimal = 1) -> Request<PriceConversion> {
        return request(method: .get, path: "price-converter", params: [
            "base_currency_id": baseCurrencyId,
            "quote_currency_id": quoteCurrencyId,
            "amount": "\(amount)"
        ])
    }

    private static func request<Model: Decodable>(method: Request<Model>.Method, path: String, params: Request<Model>.Params?) -> Request<Model> {
        let auth: Request<Model>.AuthorisationMethod = Configuration.apiKey.map { .bearer(token: $0) } ?? .none
        return Request<Model>(baseUrl: Configuration.baseUrl, method: method, path: path, params: params, userAgent: Configuration.userAgent, authorisation: auth)
    }
       
    private static func compact(_ optional: [String: Any?]) -> [String: Any] {
        return optional.compactMapValues { $0 }
    }
}
