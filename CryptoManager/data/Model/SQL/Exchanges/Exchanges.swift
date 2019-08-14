//
//  CurrencyAndConversions.swift
//  CryptoManager
//
//  Created by Jonny Caley on 14/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

struct Exchanges : Codable {
    let exchange: String
    let currencyConversions: [CurrencyAndConversions]
}

// MARK: - Rates
struct CurrencyAndConversions: Codable {
    let base: String
    let rates: [String]
}
