//
//  PriceConversion.swift
//  Coinpaprika
//

import Foundation
#if canImport(CoinpaprikaNetworking)
import CoinpaprikaNetworking
#endif

/// Result of converting an amount from one currency to another (returned by `/price-converter`).
public struct PriceConversion: Equatable, CodableModel {

    /// Source currency id, eg. `btc-bitcoin`.
    public let baseCurrencyId: String

    /// Source currency display name.
    public let baseCurrencyName: String

    /// When the source price was last updated.
    public let basePriceLastUpdated: Date?

    /// Target currency id, eg. `usd-us-dollars`.
    public let quoteCurrencyId: String

    /// Target currency display name.
    public let quoteCurrencyName: String

    /// When the target price was last updated.
    public let quotePriceLastUpdated: Date?

    /// Source amount that was converted.
    public let amount: Decimal

    /// Resulting price in the target currency.
    public let price: Decimal

    enum CodingKeys: String, CodingKey {
        case baseCurrencyId = "base_currency_id"
        case baseCurrencyName = "base_currency_name"
        case basePriceLastUpdated = "base_price_last_updated"
        case quoteCurrencyId = "quote_currency_id"
        case quoteCurrencyName = "quote_currency_name"
        case quotePriceLastUpdated = "quote_price_last_updated"
        case amount
        case price
    }
}
