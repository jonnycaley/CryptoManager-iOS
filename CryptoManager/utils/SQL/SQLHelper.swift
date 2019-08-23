//
//  SQLHelper.swift
//  CryptoManager
//
//  Created by Jonny Caley on 23/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

class SQLHelper: DataHelperProtocol {
    
}

protocol DataHelperProtocol {
    associatedtype T
    static func createTable() -> Void
    static func insert(item: T) -> Int64
    static func delete(item: T) -> Void
    static func findAll() -> [T]?
}
