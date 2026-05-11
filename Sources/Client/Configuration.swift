//
//  Configuration.swift
//  
//
//  Created by Dominique Stranz on 01/08/2019.
//

import Foundation

public typealias CoinpaprikaConfiguration = Configuration

public struct Configuration {
    public static var baseUrl = URL(string: "https://api.coinpaprika.com/v1/")!
    public static var userAgent = "Coinpaprika API Client - Swift"

    /// API key used to authenticate requests against api-pro.coinpaprika.com.
    /// When non-nil, every static `Coinpaprika.API.*` call sends the key on
    /// the `Authorization` header. Default is nil (free tier, no auth).
    ///
    /// Paid plans require both `apiKey` and `baseUrl` set:
    ///
    ///     Configuration.apiKey = "your-api-key"
    ///     Configuration.baseUrl = URL(string: "https://api-pro.coinpaprika.com/v1/")!
    public static var apiKey: String?
}
