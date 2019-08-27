//
//  SQLCrypto.swift
//  CryptoManager
//
//  Created by Jonny Caley on 24/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import GRDB

struct SQLCrypto: Codable, Equatable {
    let id: String
    let imageUrl: String
    let linkUrl: String
    let name: String
    let symbol: String
    let coinName: String
    let fullName: String
    let sortOrder: String
}

extension SQLCrypto: FetchableRecord, TableRecord {}

extension SQLCrypto: MutablePersistableRecord {}

extension SQLCrypto {
    fileprivate enum Columns {
        static let id = Column(CodingKeys.id)
        static let imageUrl = Column(CodingKeys.imageUrl)
        static let linkUrl = Column(CodingKeys.linkUrl)
        static let name = Column(CodingKeys.name)
        static let symbol = Column(CodingKeys.symbol)
        static let coinName = Column(CodingKeys.coinName)
        static let fullName = Column(CodingKeys.fullName)
        static let sortOrder = Column(CodingKeys.sortOrder)
    }
}
