//
//  Rates.swift
//  CryptoManager
//
//  Created by Jonny Caley on 13/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

// MARK: - Rates
struct Rates: Codable {
    let rates: [String: Double]
    let base, date: String
}
