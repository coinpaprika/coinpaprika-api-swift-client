//
//  ChangelogEntry.swift
//  Coinpaprika
//

import Foundation
#if canImport(CoinpaprikaNetworking)
import CoinpaprikaNetworking

/// A single coin id change recorded in the Coinpaprika changelog
/// (returned by `/changelog/ids`, paid plans).
public struct ChangelogEntry: Equatable, CodableModel {

    /// Current coin id, eg. `btc-bitcoin`.
    public let currencyId: String?

    /// Previous coin id before the change.
    public let oldId: String?

    /// New coin id after the change.
    public let newId: String?

    /// When the id was changed, RFC3999 (ISO-8601) format.
    public let changedAt: String?

    enum CodingKeys: String, CodingKey {
        case currencyId = "currency_id"
        case oldId = "old_id"
        case newId = "new_id"
        case changedAt = "changed_at"
    }
}
#endif
