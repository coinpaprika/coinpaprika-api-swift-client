//
//  Contract.swift
//  Coinpaprika
//

import Foundation
#if canImport(CoinpaprikaNetworking)
import CoinpaprikaNetworking

/// Smart-contract address mapped to a coin id (returned by `/contracts/{platform_id}`).
public struct Contract: Equatable, CodableModel {

    /// Smart contract address on the platform, eg. `0xdac17f958d2ee523a2206206994597c13d831ec7`.
    public let address: String

    /// Contract type, eg. `ERC20`.
    public let type: String

    /// Coinpaprika coin id this contract maps to, eg. `usdt-tether`.
    public let id: String

    /// Whether the contract is currently active.
    public let active: Bool

    enum CodingKeys: String, CodingKey {
        case address
        case type
        case id
        case active
    }
}
#endif
