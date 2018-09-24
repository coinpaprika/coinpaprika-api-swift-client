# Coinpaprika API Swift Client

[![CI Status](https://img.shields.io/travis/coinpaprika/coinpaprika-api-swift-client.svg?style=flat)](https://travis-ci.org/coinpaprika/coinpaprika-api-swift-client)
[![Version](https://img.shields.io/cocoapods/v/CoinpaprikaAPI.svg?style=flat)](https://cocoapods.org/pods/CoinpaprikaAPI)
[![License](https://img.shields.io/cocoapods/l/CoinpaprikaAPI.svg?style=flat)](https://cocoapods.org/pods/CoinpaprikaAPI)
[![Platform](https://img.shields.io/cocoapods/p/CoinpaprikaAPI.svg?style=flat)](https://cocoapods.org/pods/CoinpaprikaAPI)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Usage

This library provides convenient way to use [Coinpaprika.com API](https://api.coinpaprika.com/) in Swift.

[Coinpaprika](https://coinpaprika.com) delivers full market data to the world of crypto: coin prices, volumes, market caps, ATHs, return rates and more.

### Market Stats

```swift
CoinpaprikaAPI.global.perform { (response) in
  switch response {
    case .success(let stats):
    // Successfully downloaded GlobalStats
    // stats.marketCapUsd - Market Capitalization in USD
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
CoinpaprikaAPI.coins.perform { (response) in
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
CoinpaprikaAPI.tickers.perform { (response) in
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
CoinpaprikaAPI.ticker(id: "bitcoin-btc").perform { (response) in
  switch response {
    case .success(let ticker):
    // Successfully downloaded Ticker
    // ticker.id - Coin identifier, to use in ticker(id:) method
    // ticker.name - Coin name, for example Bitcoin
    // ticker.symbol - Coin symbol, for example BTC
    // ticker.rank - Position in Coinpaprika ranking (by MarketCap)
    // ticker.priceUsd - Price in USD
    // ticker.priceBtc - Price in BTC
    // ticker.volume24hUsd - Volume from last 24h in USD
    // ticker.marketCapUsd - Market Capitalization in USD
    // ticker.circulatingSupply - Circulating Supply
    // ticker.totalSupply - Total Supply
    // ticker.maxSupply - Maximum Supply
    // ticker.percentChange1h - Percentage price change in last 1 hour
    // ticker.percentChange24h - Percentage price change in last 24 hours
    // ticker.percentChange7d - Percentage price change in last 7 days
    case .failure(let error):
    // Failure reason as error
  }
}
```

## Installation

CoinpaprikaAPI is available through [CocoaPods](https://cocoapods.org). To install it, simply add the following line to your Podfile:

```ruby
pod 'CoinpaprikaAPI'
```

## Dependencies

* [CodableExtensions](https://cocoapods.org/pods/CodableExtensions) - Codable extension with custom converters


## License

CoinpaprikaAPI is available under the MIT license. See the LICENSE file for more info.
