//
//  CurrencyAndConversions.swift
//  CryptoManager
//
//  Created by Jonny Caley on 19/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

struct CurrencyAndConversions: Codable {
    let base: String
    let rates: [String]
}
