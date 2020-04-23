//
//  Utils.swift
//  Currency Converter
//
//  Created by Gary on 4/22/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import Foundation

//  the idea for this app came from Dmitry Novosyolov's SwiftUI version on youtube:
//  https://www.youtube.com/watch?v=iKxYwlh05S8&t=519s
//  the next two functions are from the video

func emojiFlag(_ countryCode: String) -> String {
    var string = ""

    countryCode.dropLast().localizedUppercase.unicodeScalars.forEach {
        string.append(UnicodeScalar(127397 + $0.value)!.description)
    }

    return string
}

func formattedRate(for currency: String, rate: Double) -> String {
    var formatter: NumberFormatter {
        let fm = NumberFormatter()
        fm.numberStyle = .currency
        fm.locale = Locale(identifier: currency.dropLast() + "_" + currency.dropLast().uppercased())
        return fm
    }

    return formatter.string(from: NSNumber(value: rate))!
}

let countryNames = [
    "CAD": "Canada",
    "COL": "Columbia",
    "HKD": "Hong Kong",
    "ISK": "Iceland",
    "PHP": "Philippines",
    "DKK": "Denmark",
    "HUF": "Hungary",
    "CZK": "Czech Republic",
    "GBP": "Great Britain",
    "RON": "Romania",
    "SEK": "Sweden",
    "IDR": "Indonesia",
    "INR": "Indian Rupee",
    "BRL": "Brazil",
    "RUB": "Russian Federation",
    "HRK": "Croatia",
    "JPY": "Japan",
    "THB": "Thailand",
    "CHF": "Swiss Franc",
    "EUR": "European Union",
    "MYR": "Malaysia",
    "BGN": "Bulgaria",
    "TRY": "Turkey",
    "CNY": "China",
    "NOK": "Norway",
    "NZD": "New Zealand",
    "ZAR": "South Africa Rand",
    "USD": "United States",
    "MXN": "Mexico",
    "SGD": "Singapore",
    "AUD": "Australia",
    "ILS": "Israel",
    "KRW": "Korea",
    "PLN": "Poland",
]
