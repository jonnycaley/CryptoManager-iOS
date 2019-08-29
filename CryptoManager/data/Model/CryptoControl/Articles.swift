// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let news = try? newJSONDecoder().decode(News.self, from: jsonData)

import Foundation

// MARK: - NewsElement
struct Article: Codable {
    let id: String?
    let hotness, activityHotness: Double?
    let primaryCategory: String?
    let words: Int?
    let similarArticles: [SimilarArticles]?
    let coins: [Coin]?
    let newsDescription, publishedAt, title: String?
    let url: String?
    let source: Source?
    let sourceDomain: String?
    let originalImageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case hotness, activityHotness, primaryCategory, words, similarArticles, coins
        case newsDescription = "description"
        case publishedAt, title, url, source, sourceDomain
        case originalImageURL = "originalImageUrl"
    }
}

// MARK: - Coin
struct Coin: Codable {
    let id, name, tradingSymbol, slug: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, tradingSymbol, slug
    }
}

// MARK: - SimilarArticle
struct SimilarArticles: Codable {
    let id, title, publishedAt, sourceDomain: String?
    let url: String?
    let thumbnail: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case title, publishedAt, sourceDomain, url, thumbnail
    }
}

// MARK: - Source
struct Source: Codable {
    let id, name: String?
    let url: String?
    let favicon: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, url, favicon
    }
}

typealias Articles = [Article]
