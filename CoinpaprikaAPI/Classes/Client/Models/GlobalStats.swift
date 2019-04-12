//
//  GlobalStats.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 17.09.2018.
//  Copyright © 2018 Grey Wizard sp. z o.o. All rights reserved.
//

import Foundation

/// Global market data
public struct GlobalStats: Equatable, CodableModel {
    
    /// Market capitalization in USD
    public let marketCapUsd: Decimal
    
    /// Market capitalization ATH in USD
    public let marketCapAthValue: Decimal
    
    /// Market capitalization ATH date
    public let marketCapAthDate: Date
    
    /// Market capitalization percentage change in last 24h
    public let marketCapChange24h: Decimal
    
    /// Volume from last 24h
    public let volume24hUsd: Decimal
    
    /// Volume 24h ATH in USD
    public let volume24hAthValue: Decimal
    
    /// Volume 24h ATH date
    public let volume24hAthDate: Date
    
    /// Volume 24h percentage change in last 24h
    public let volume24hChange24h: Decimal
    
    /// Bitcoin share in whole market capitalization
    public let bitcoinDominancePercentage: Decimal
    
    /// Number of cryptocurrencies
    public let cryptocurrenciesNumber: Int
    
    /// Last update time
    //  public let lastUpdated: Date
    
    enum CodingKeys: String, CodingKey {
        case marketCapUsd = "market_cap_usd"
        case volume24hUsd = "volume_24h_usd"
        case bitcoinDominancePercentage = "bitcoin_dominance_percentage"
        case cryptocurrenciesNumber = "cryptocurrencies_number"
        //case lastUpdated = "last_updated"
        case marketCapAthValue = "market_cap_ath_value"
        case marketCapAthDate = "market_cap_ath_date"
        case volume24hAthValue = "volume_24h_ath_value"
        case volume24hAthDate = "volume_24h_ath_date"
        case marketCapChange24h = "market_cap_change_24h"
        case volume24hChange24h = "volume_24h_change_24h"
    }
}
