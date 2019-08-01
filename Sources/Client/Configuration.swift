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
}
