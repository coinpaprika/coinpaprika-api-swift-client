# Coinpaprika API Swift Client

[![CI Status](https://img.shields.io/travis/coinpaprika/coinpaprika-api-swift-client.svg?style=flat)](https://travis-ci.org/coinpaprika/coinpaprika-api-swift-client)
[![Version](https://img.shields.io/cocoapods/v/CoinpaprikaAPI.svg?style=flat)](https://cocoapods.org/pods/CoinpaprikaAPI)
[![License](https://img.shields.io/cocoapods/l/CoinpaprikaAPI.svg?style=flat)](https://cocoapods.org/pods/CoinpaprikaAPI)
[![Platform](https://img.shields.io/cocoapods/p/CoinpaprikaAPI.svg?style=flat)](https://cocoapods.org/pods/CoinpaprikaAPI)

## Usage

This library provides convenient way to use [Coinpaprika.com API](https://api.coinpaprika.com/) in Swift.

Coinpaprika delivers full market data to the world of crypto: coin prices, volumes, market caps, ATHs, return rates and more.

### Market Stats

```swift
CoinpaprikaAPI.global.perform { (response) in
  switch response {
    case .success(let stats):
    // Successfully downloaded GlobalStats
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
    // Sucesfully downloaded [Ticker]
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

## License

CoinpaprikaAPI is available under the MIT license. See the LICENSE file for more info.
