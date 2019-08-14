//
//  SQLExchangeRates.swift
//  CryptoManager
//
//  Created by Jonny Caley on 13/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

class SQLExchangeRates {
    // Name | Employee Id | Designation
    var currency: String
    var rate: Double
    
    init(currency: String, rate: Double) {
        self.currency = currency
        self.rate = rate
    }
}
