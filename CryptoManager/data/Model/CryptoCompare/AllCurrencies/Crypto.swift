//
//  Crypto.swift
//  CryptoManager
//
//  Created by Jonny Caley on 14/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

// MARK: - Crypto
struct Crypto: Codable {
    let response, message: String
    let data: [String: Datum]
    let baseImageURL, baseLinkURL: String
    let rateLimit: RateLimit
    let hasWarning: Bool
    let type: Int
    
    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case message = "Message"
        case data = "Data"
        case baseImageURL = "BaseImageUrl"
        case baseLinkURL = "BaseLinkUrl"
        case rateLimit = "RateLimit"
        case hasWarning = "HasWarning"
        case type = "Type"
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id, url: String
    let imageURL: String?
    let contentCreatedOn: Int
    let name, symbol, coinName, fullName: String
    let algorithm, proofType, fullyPremined, totalCoinSupply: String
    let builtOn, smartContractAddress: String
    let preMinedValue, totalCoinsFreeFloat: PreMinedValue
    let sortOrder: String
    let sponsored, isTrading: Bool
    let totalCoinsMined: Double?
    let blockNumber: Int?
    let netHashesPerSecond, blockReward: Double?
    let blockTime: Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case url = "Url"
        case imageURL = "ImageUrl"
        case contentCreatedOn = "ContentCreatedOn"
        case name = "Name"
        case symbol = "Symbol"
        case coinName = "CoinName"
        case fullName = "FullName"
        case algorithm = "Algorithm"
        case proofType = "ProofType"
        case fullyPremined = "FullyPremined"
        case totalCoinSupply = "TotalCoinSupply"
        case builtOn = "BuiltOn"
        case smartContractAddress = "SmartContractAddress"
        case preMinedValue = "PreMinedValue"
        case totalCoinsFreeFloat = "TotalCoinsFreeFloat"
        case sortOrder = "SortOrder"
        case sponsored = "Sponsored"
        case isTrading = "IsTrading"
        case totalCoinsMined = "TotalCoinsMined"
        case blockNumber = "BlockNumber"
        case netHashesPerSecond = "NetHashesPerSecond"
        case blockReward = "BlockReward"
        case blockTime = "BlockTime"
    }
}

enum PreMinedValue: String, Codable {
    case nA = "N/A"
}

// MARK: - RateLimit
struct RateLimit: Codable {
}
