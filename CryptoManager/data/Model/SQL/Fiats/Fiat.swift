//
//  Fiat.swift
//  CryptoManager
//
//  Created by Jonny Caley on 20/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

struct Fiat : Codable {
    let fiat: String
    let rate: Double
    let isBaseRate: Bool
}
