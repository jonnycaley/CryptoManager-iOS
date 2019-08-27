//
//  Fiat.swift
//  CryptoManager
//
//  Created by Jonny Caley on 20/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import GRDB

struct SQLFiat : Codable, Equatable {
    let name: String
    let rate: Double
    var isBaseFiat: Bool
}

extension SQLFiat: FetchableRecord, TableRecord {}

extension SQLFiat: MutablePersistableRecord {}

extension SQLFiat {
    fileprivate enum Columns {
        static let name = Column(CodingKeys.name)
        static let rate = Column(CodingKeys.rate)
        static let isBaseFiat = Column(CodingKeys.isBaseFiat)
    }
}
