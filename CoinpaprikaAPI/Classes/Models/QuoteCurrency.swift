//
//  Quote.swift
//  Coinpaprika
//
//  Created by Dominique Stranz on 07/11/2018.
//

import Foundation

/// Quote Currency - for use as query parameter and to access quote values in desired currency
public enum QuoteCurrency: String, Codable, CaseIterable {
    /// Bitcoin
    case btc = "BTC"
    
    /// Ethereum
    case eth = "ETH"
    
    /// US Dollars
    case usd = "USD"
    
    /// Euro
    case eur = "EUR"
    
    /// South Korea Won
    case krw = "KRW"
    
    /// Pound Sterling
    case gbp = "GBP"
    
    /// Canadian Dollar
    case cad = "CAD"
    
    /// Japanese Yen
    case jpy = "JPY"
    
    /// Polish Zloty
    case pln = "PLN"
    
    /// Russian Ruble
    case rub = "RUB"
    
    /// Turkish Lira
    case `try` = "TRY"
    
    /// New Zealand Dollar
    case nzd = "NZD"
    
    /// Australian Dollar
    case aud = "AUD"
    
    /// Swiss Franc
    case chf = "CHF"
    
    /// Ukrainian Hryvnia
    case uah = "UAH"
    
    /// Hong Kong Dollar
    case hkd = "HKD"
    
    /// Singapore Dollar
    case sgd = "SGD"
    
    /// Nigerian Naira
    case ngn = "NGN"
    
    /// Philippines Piso
    case php = "PHP"
    
    /// Mexican Peso
    case mxn = "MXN"
    
    /// Brazil Real
    case brl = "BRL"
    
    /// Thai Baht
    case thb = "THB"
    
    /// Chilean Peso
    case clp = "CLP"
    
    /// Yuan Renminbi
    case cny = "CNY"
    
    /// Czech Koruna
    case czk = "CZK"
    
    /// Danish Krone
    case dkk = "DKK"
    
    /// Hungarian Forint
    case huf = "HUF"
    
    /// Indonesian Rupiah
    case idr = "IDR"
    
    /// Israeli Shekel
    case ils = "ILS"
    
    /// Indian Rupee
    case inr = "INR"
    
    /// Malaysian Ringgit
    case myr = "MYR"
    
    /// Norwegian Krone
    case nok = "NOK"
    
    /// Pakistani Rupee
    case pkr = "PKR"
    
    /// Swedish Krona
    case sek = "SEK"
    
    /// Taiwan New Dollar
    case twd = "TWD"
    
    /// South African Rand
    case zar = "ZAR"
    
    /// Vietnamese Dong
    case vnd = "VND"
    
    /// Bolivian Boliviano
    case bob = "BOB"
    
    /// Colombian Peso
    case cop = "COP"
    
    /// Peruvian Sol
    case pen = "PEN"
    
    /// Argentine Peso
    case ars = "ARS"
    
    /// Icelandic krona
    case isk = "ISK"
    
    /// Currency code, eg. USD
    public var code: String {
        return rawValue
    }
    
    /// Currency symbol, eg. $
    public var symbol: String {
        switch self {
        case .btc:
            return "₿"
        case .eth:
            return "Ξ"
        case .usd:
            return "$"
        case .eur:
            return "€"
        case .krw:
            return "₩"
        case .gbp:
            return "£"
        case .cad:
            return "$"
        case .jpy:
            return "¥"
        case .pln:
            return "zł"
        case .rub:
            return "₽"
        case .try:
            return "₺"
        case .nzd:
            return "$"
        case .aud:
            return "$"
        case .chf:
            return "CHF"
        case .uah:
            return "₴"
        case .hkd:
            return "$"
        case .sgd:
            return "$"
        case .ngn:
            return "₦"
        case .php:
            return "₱"
        case .mxn:
            return "$"
        case .brl:
            return "R$"
        case .thb:
            return "฿"
        case .clp:
            return "$"
        case .cny:
            return "¥"
        case .czk:
            return "Kč"
        case .dkk:
            return "kr."
        case .huf:
            return "Ft"
        case .idr:
            return "Rp"
        case .ils:
            return "₪"
        case .inr:
            return "₹"
        case .myr:
            return "RM"
        case .nok:
            return "kr"
        case .pkr:
            return "₨"
        case .sek:
            return "kr"
        case .twd:
            return "$"
        case .zar:
            return "R"
        case .vnd:
            return "₫"
        case .bob:
            return "Bs."
        case .cop:
            return "$"
        case .pen:
            return "S/"
        case .ars:
            return "$"
        case .isk:
            return "kr"
        }
    }
}

extension QuoteCurrency: QueryRepresentable {
    var queryValue: String {
        return code
    }
}
