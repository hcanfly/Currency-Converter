//
//  Model.swift
//  Currency Converter
//
//  Created by Gary on 4/22/20.
//  Copyright © 2020 Gary Hanson. All rights reserved.
//

import Foundation


struct ExchangeRate : Decodable {
    let currency: String
    let rate: Double
}

struct Rates : Decodable {
    let base: String
    let date: String
    let rates: [String : Double]
}
