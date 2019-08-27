//
//  SQLExchanges.swift
//  CryptoManager
//
//  Created by Jonny Caley on 19/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import GRDB

struct SQLExchange : Codable, Equatable {
    let name: String
    let currencyConversions: String
}

extension SQLExchange : FetchableRecord, TableRecord {}

extension SQLExchange : MutablePersistableRecord {}

extension SQLExchange {
    fileprivate enum Columns {
        static let name = Column(CodingKeys.name)
        static let currencyConversions = Column(CodingKeys.currencyConversions)
    }
}
