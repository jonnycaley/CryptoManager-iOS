//
//  SQLArticle.swift
//  CryptoManager
//
//  Created by Jonny Caley on 29/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import GRDB

struct SQLArticle : Codable, Equatable {
    let id: String
    let hotness, activityHotness: Double
    let primaryCategory: String
    let words: Int
    let coins, newsDescription, publishedAt, title, url, originalImageURL: String
}

extension SQLArticle : FetchableRecord, TableRecord {}

extension SQLArticle : MutablePersistableRecord {}

extension SQLArticle {
    fileprivate enum Columns {
        static let id = Column(CodingKeys.id)
        static let hotness = Column(CodingKeys.hotness)
        static let activityHotness = Column(CodingKeys.activityHotness)
        static let primaryCategory = Column(CodingKeys.primaryCategory)
        static let words = Column(CodingKeys.words)
        static let coins = Column(CodingKeys.coins) //[Coin]?
        static let newsDescription = Column(CodingKeys.newsDescription)
        static let publishedAt = Column(CodingKeys.publishedAt)
        static let title = Column(CodingKeys.title)
        static let url = Column(CodingKeys.url)
        static let originalImageURL = Column(CodingKeys.originalImageURL)
    }
}
