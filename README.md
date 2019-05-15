# Coinpaprika API Swift Client

[![Build Status](https://travis-ci.org/coinpaprika/coinpaprika-api-swift-client.svg?branch=master)](https://travis-ci.org/coinpaprika/coinpaprika-api-swift-client)
[![Version](https://img.shields.io/cocoapods/v/CoinpaprikaAPI.svg?style=flat)](https://cocoapods.org/pods/CoinpaprikaAPI)
[![License](https://img.shields.io/cocoapods/l/CoinpaprikaAPI.svg?style=flat)](https://cocoapods.org/pods/CoinpaprikaAPI)
[![Platform](https://img.shields.io/cocoapods/p/CoinpaprikaAPI.svg?style=flat)](https://cocoapods.org/pods/CoinpaprikaAPI)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
![Swift 5.0](https://img.shields.io/badge/swift-4.2%20%7C%205.0-orange.svg)

### [Documentation](https://coinpaprika.github.io/coinpaprika-api-swift-client) | [Repository](https://github.com/coinpaprika/coinpaprika-api-swift-client) | [Installation](#installation)

## Usage

This library provides convenient way to use [Coinpaprika.com API](https://api.coinpaprika.com/) in Swift.

[Coinpaprika](https://coinpaprika.com) delivers full market data to the world of crypto: coin prices, volumes, market caps, ATHs, return rates and more.

### Import

### Market Stats

```swift
import Coinpaprika

Coinpaprika.API.global().perform { (response) in
  switch response {
    case .success(let stats):
    // Successfully downloaded GlobalStats
    // stats.marketCapUsd - Market capitalization in USD
    // stats.volume24hUsd - Volume from last 24h in USD
    // stats.bitcoinDominancePercentage - Percentage share of Bitcoin MarketCap in Total MarketCap
    // stats.cryptocurrenciesNumber - Number of cryptocurrencies available on Coinpaprika
    case .failure(let error):
    // Failure reason as error
  }
}
```

### Coins list

```swift
import Coinpaprika

Coinpaprika.API.coins().perform { (response) in
  switch response {
    case .success(let coins):
    // Successfully downloaded [Coin]
    // coins[0].id - Coin identifier, to use in ticker(id:) method
    // coins[0].name - Coin name, for example Bitcoin
    // coins[0].symbol - Coin symbol, for example BTC
    case .failure(let error):
    // Failure reason as error
  }
}
```

### Ticker data for all coins

```swift
import Coinpaprika

Coinpaprika.API.tickers(quotes: [.usd, .btc]).perform { (response) in
  switch response {
    case .success(let tickers):
    // Successfully downloaded [Ticker]
    // tickers[0] - see the next method for Ticker properties
    case .failure(let error):
    // Failure reason as error
  }
}

```

### Ticker data for selected coin

```swift
import Coinpaprika

Coinpaprika.API.ticker(id: "bitcoin-btc", quotes: [.usd, .btc]).perform { (response) in
  switch response {
    case .success(let ticker):
    // Successfully downloaded Ticker
    // ticker.id - Coin identifier, to use in ticker(id:) method
    // ticker.name - Coin name, for example Bitcoin
    // ticker.symbol - Coin symbol, for example BTC
    // ticker.rank - Position in Coinpaprika ranking (by MarketCap)
    // ticker.circulatingSupply - Circulating Supply
    // ticker.totalSupply - Total Supply
    // ticker.maxSupply - Maximum Supply
    // ticker.betaValue - Beta
    // ticker.lastUpdated - Last updated date
    //
    // Each Ticker could contain several Ticker.Quote (according to provided quotes parameter). To access to quote for given currency, use subscripting like:
    // - ticker[.usd] - Ticker.Quote in USD
    // - ticker[.btc] - Ticker.Quote in BTC
    // etc...
    //
    // So how to get this cryptocurrency price in USD and BTC?
    // - ticker[.usd].price - Coin price in USD
    // - ticker[.btc].price - Coin price in BTC
    //
    // Ticker.Quote contains following properties:
    // let currency: QuoteCurrency = .usd
    // - ticker[currency].price - Price
    // - ticker[currency].volume24h - Volume from last 24h
    // - ticker[currency].volume24hChange24h - Volume change in last 24h
    // - ticker[currency].marketCap - Market capitalization
    // - ticker[currency].marketCapChange24h - Market capitalization in last 24h
    // - ticker[currency].percentChange1h - Percentage price change in last 1 hour
    // - ticker[currency].percentChange12h - Percentage price change in last 12 hour
    // - ticker[currency].percentChange24h - Percentage price change in last 24 hour
    // - ticker[currency].percentChange7d - Percentage price change in last 7 days
    // - ticker[currency].percentChange30d - Percentage price change in last 30 days
    // - ticker[currency].percentChange1y - Percentage price change in last 1 year
    // - ticker[currency].athPrice - ATH price
    // - ticker[currency].athDate - ATH date
    // - ticker[currency].percentFromPriceAth - Percentage price change from ATH
    // - ticker[currency].volumeMarketCapRate - Volume/MarketCap rate
    case .failure(let error):
    // Failure reason as error
  }
}
```

### Search

```swift
import Coinpaprika

Coinpaprika.API.search(query: "bitcoin", categories: [.coins, .exchanges, .icos, .people, .tags], limit: 20).perform { (response) in
  switch response {
    case .success(let searchResults):
    // Successfully downloaded SearchResults
    // searchResults.currencies - list of matching coins as [Search.Coin]
    // searchResults.icos - list of matching ICOs as [Search.Ico]
    // searchResults.exchanges - list of matching exchanges as [Search.Exchange]
    // searchResults.people - list of matching people as [Search.Person]
    // searchResults.tags - list of matching tags as [Search.Tag]
    case .failure(let error):
    // Failure reason as error
  }
}
```

### More

Other endpoints could be found in [CoinpaprikaAPI reference](https://coinpaprika.github.io/coinpaprika-api-swift-client/Structs/CoinpaprikaAPI.html).

## Installation

### Cocoapods

CoinpaprikaAPI is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'CoinpaprikaAPI'
```

Run `pod install` to integrate `CoinpaprikaAPI` with your workspace.

### Carthage

CoinpaprikaAPI is available through [Carthage](https://github.com/Carthage/Carthage). To install it, simply add the following line to your Carthage file:


```
github "coinpaprika/coinpaprika-api-swift-client"  
```

Run `carthage update` to build the framework and drag the built `CoinpaprikaAPI.framework` into your Xcode project.

## License

CoinpaprikaAPI is available under the MIT license. See the LICENSE file for more info.
