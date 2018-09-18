//
//  Ticker.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 05.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation
import CodableExtensions

public struct Ticker: Decodable, Equatable {
    public let id: String
    public let name: String
    public let symbol: String
    public let rank: Int32
    public let priceUsd: Decimal
    public let priceBtc: Decimal
    public let volume24hUsd: Int64
    public let marketCapUsd: Int64
    public let circulatingSupply: Int64
    public let totalSupply: Int64
    public let maxSupply: Int64
    public let percentChange1h: Decimal
    public let percentChange24h: Decimal
    public let percentChange7d: Decimal
    public let lastUpdated: Date?

    enum CodingKeys: String, CodingKey {
        case id, name, rank, symbol
        case priceBtc = "price_btc"
        case priceUsd = "price_usd"
        case volume24hUsd = "volume_24h_usd"
        case marketCapUsd = "market_cap_usd"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case percentChange1h = "percent_change_1h"
        case percentChange24h = "percent_change_24h"
        case percentChange7d = "percent_change_7d"
        case lastUpdated = "last_updated"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        rank = try values.decode(.rank, transformer: StringToInt32Transformer())
        symbol = try values.decode(String.self, forKey: .symbol)

        priceBtc = try values.decode(.priceBtc, transformer: StringToDecimalTransformer())
        priceUsd = try values.decode(.priceUsd, transformer: StringToDecimalTransformer())

        volume24hUsd = try values.decode(.volume24hUsd, transformer: StringToInt64Transformer())
        marketCapUsd = try values.decode(.marketCapUsd, transformer: StringToInt64Transformer())

        circulatingSupply = try values.decode(.circulatingSupply, transformer: StringToInt64Transformer())
        totalSupply = try values.decode(.totalSupply, transformer: StringToInt64Transformer())
        maxSupply = try values.decode(.maxSupply, transformer: StringToInt64Transformer())

        percentChange1h = try values.decode(.percentChange1h, transformer: StringToDecimalTransformer())
        percentChange24h = try values.decode(.percentChange24h, transformer: StringToDecimalTransformer())
        percentChange7d = try values.decode(.percentChange7d, transformer: StringToDecimalTransformer())

        lastUpdated = try values.decode(.lastUpdated, transformer: StringToDateTransformer())
    }
}
