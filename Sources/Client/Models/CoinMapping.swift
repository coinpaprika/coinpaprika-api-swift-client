//
//  CoinMapping.swift
//  Coinpaprika
//

import Foundation
#if canImport(CoinpaprikaNetworking)
import CoinpaprikaNetworking
#endif

/// ID mapping between Coinpaprika and other providers (returned by `/coins/mappings`, paid plans).
///
/// The API returns an empty string for missing values rather than `null`. The decoder
/// normalizes both to `nil` so callers can use a single `if let` pattern.
public struct CoinMapping: Equatable, CodableModel {

    /// Coinpaprika ID, eg. `btc-bitcoin`.
    public let coinpaprika: String?

    /// Coinmarketcap numeric ID as a string.
    public let coinmarketcap: String?

    /// CoinGecko ID, eg. `bitcoin`.
    public let coingecko: String?

    /// Cryptocompare numeric ID as a string.
    public let cryptocompare: String?

    /// International Securities Identification Number.
    public let isin: String?

    /// Digital Token Identifier.
    public let dti: String?

    /// Mapping last update timestamp, RFC3999 (ISO-8601) format.
    public let updatedAt: String?

    public init(coinpaprika: String?, coinmarketcap: String?, coingecko: String?, cryptocompare: String?, isin: String?, dti: String?, updatedAt: String?) {
        self.coinpaprika = coinpaprika
        self.coinmarketcap = coinmarketcap
        self.coingecko = coingecko
        self.cryptocompare = cryptocompare
        self.isin = isin
        self.dti = dti
        self.updatedAt = updatedAt
    }

    enum CodingKeys: String, CodingKey {
        case coinpaprika
        case coinmarketcap
        case coingecko
        case cryptocompare
        case isin
        case dti
        case updatedAt = "updated_at"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.coinpaprika   = try CoinMapping.decodeNonEmpty(container, forKey: .coinpaprika)
        self.coinmarketcap = try CoinMapping.decodeNonEmpty(container, forKey: .coinmarketcap)
        self.coingecko     = try CoinMapping.decodeNonEmpty(container, forKey: .coingecko)
        self.cryptocompare = try CoinMapping.decodeNonEmpty(container, forKey: .cryptocompare)
        self.isin          = try CoinMapping.decodeNonEmpty(container, forKey: .isin)
        self.dti           = try CoinMapping.decodeNonEmpty(container, forKey: .dti)
        self.updatedAt     = try CoinMapping.decodeNonEmpty(container, forKey: .updatedAt)
    }

    private static func decodeNonEmpty(_ container: KeyedDecodingContainer<CodingKeys>, forKey key: CodingKeys) throws -> String? {
        let value = try container.decodeIfPresent(String.self, forKey: key)
        if let value = value, !value.isEmpty {
            return value
        }
        return nil
    }
}
