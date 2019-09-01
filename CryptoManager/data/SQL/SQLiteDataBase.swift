//
//  SQLiteDataBase.swift
//  CryptoManager
//
//  Created by Jonny Caley on 23/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import SQLite
import RxGRDB
import GRDB
import RxSwift

class SQLiteDataBase {
    static let sharedInstance = SQLiteDataBase()
    //    var database: Connection!
    var dbQueue: DatabaseQueue!
    var dbPool: DatabasePool!
    
    private init() {
        do {
            print("init")
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("fiats").appendingPathExtension("sqlite3")
            
            //            let database = try Connection(fileUrl.path)
            //            self.database = database
            self.dbQueue = try DatabaseQueue(path: fileUrl.path)
            self.dbPool = try DatabasePool(path: fileUrl.path)
        } catch {
            print(error)
            self.dbPool = nil
            //            self.database = nil
            self.dbQueue = nil
        }
    }
    
    func createFiatsTable() -> Single<Bool> {
        
        return dbQueue.rx.writeAndReturn { db -> Bool in
            do {
                try db.create(table: "SQLFiat") { table in
                    table.column("name", .text).primaryKey()
                    table.column("rate", .double)
                    table.column("isBaseFiat", .boolean)
                }
                return true
            } catch {
                //table already exists
                print(error)
                return false
            }
        }
    }
    
    func sqlInsertFiats(fiats: [SQLFiat]) -> Completable {
        
        return dbQueue.rx.write { db in
            
            fiats.forEach{ (fiat) in
                let name = fiat.name
                let rate = fiat.rate
                let isBaseFiat = fiat.isBaseFiat
                
                var sqlFiat = SQLFiat(name: name, rate: rate, isBaseFiat: isBaseFiat)
                
                do {
                    try sqlFiat.insert(db)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func sqlRemoveSavedArticle(articleId: String) -> Completable {
        return dbQueue.rx.write { db in
            do {
                try db.execute(sql: "DELETE FROM SQLArticle WHERE id = '\(articleId)'")
            } catch {
                print(error)
            }
        }
    }
    
    func getFiats() -> Single<[SQLFiat]> {
        return dbQueue.rx.read { db in
            try SQLFiat.fetchAll(db)
        }
    }
    
    func setBaseFiat(chosenFiat: SQLFiat) -> Completable {
        
        return dbQueue.rx.write { db in
            do {
                if var fiat = try SQLFiat.fetchOne(db, sql: "SELECT * FROM SQLFiat WHERE isBaseFiat = true") {
                    fiat.isBaseFiat = false
                    try fiat.update(db)
                }
                if var fiat = try SQLFiat.filter(key: ["name": chosenFiat.name]).fetchOne(db) {
                    fiat.isBaseFiat = true
                    try fiat.update(db)
                }
            } catch {
                print(error)
            }
        }
    }
    
    func getBaseFiat() -> Single<SQLFiat> {
        return dbQueue.rx.read { db in
            try SQLFiat.filter(Column("isBaseFiat")).fetchOne(db)!
        }
    }
    
    func createCryptoTable() -> Single<Bool> {
        
        return dbQueue.rx.writeAndReturn { db -> Bool in
            do {
                try db.create(table: "SQLCrypto") { table in
                    table.column("id", .text).primaryKey()
                    table.column("imageUrl", .text)
                    table.column("linkUrl", .text)
                    table.column("name", .text)
                    table.column("symbol", .text)
                    table.column("coinName", .text)
                    table.column("fullName", .text)
                    table.column("sortOrder", .text)
                }
                return true
            } catch {
                //table already exists
                print(error)
                return false
            }
        }
    }
    
    func sqlInstertCrypto(cryptos: Crypto) -> Completable {
        return dbQueue.rx.write { db in
            cryptos.data.forEach { (crypto) in
                
                let id = crypto.value.id
                let imageUrl = crypto.value.imageURL.map { cryptos.baseImageURL + $0 } ?? ""
                let linkUrl = cryptos.baseLinkURL + crypto.value.url
                let name = crypto.value.name
                let symbol = crypto.value.symbol
                let coinName = crypto.value.coinName
                let fullName = crypto.value.fullName
                let sortOrder = crypto.value.sortOrder
                
                var sqlCrypto = SQLCrypto(id: id, imageUrl: imageUrl, linkUrl: linkUrl, name: name, symbol: symbol, coinName: coinName, fullName: fullName, sortOrder: sortOrder)
                
                do {
                    try sqlCrypto.insert(db)
                } catch {
                    print(error)
                }
            }
        }
    }
    
    func createExchangesTable() -> Single<Bool> {
        
        return dbQueue.rx.writeAndReturn { db -> Bool in
            do {
                try db.create(table: "SQLExchange") { table in
                    table.column("name", .text).primaryKey()
                    table.column("currencyConversions", .text)
                }
                return true
            } catch {
                //table already exists
                print(error)
                return false
            }
        }
    }
    
    func createBookmarkedArticlesTable() -> Single<Bool> {
        
        return dbQueue.rx.writeAndReturn { db -> Bool in
            do {
                try db.create(table: "SQLArticle") { table in
                    table.column("id", .text).primaryKey()
                    table.column("hotness", .double)
                    table.column("activityHotness", .double)
                    table.column("primaryCategory", .text)
                    table.column("words", .integer)
                    table.column("coins", .text) //[Coin]?
                    table.column("newsDescription", .text)
                    table.column("publishedAt", .text)
                    table.column("title", .text)
                    table.column("url", .text)
                    table.column("originalImageURL", .text)
                }
                return true
            } catch {
                //table already exists
                print(error)
                return false
            }
        }
    }
    
    func getSavedArticles() -> Single<[SQLArticle]>{
        return dbQueue.rx.read { db in
            try SQLArticle.fetchAll(db)
        }
    }
    
    func getSavedArticleCount(articleId : String) -> Single<Int> {
        return dbQueue.rx.read { db in
            try SQLArticle.filter(key: ["id": articleId]).fetchCount(db)
        }
    }
    
    func sqlInsertSavedArticle(article: SQLArticle) -> Completable {
        
        return dbQueue.rx.write { db in
            
            var sqlArticle = article
            
            do {
                try sqlArticle.insert(db)
            } catch {
                print(error)
            }
        }
    }
    
    func sqlInsertExchanges(exchanges: [SQLExchange]) -> Completable {
        
        return dbQueue.rx.write { db in
            
            exchanges.forEach { (exchange) in
                
                let name = exchange.name
                let currencyConversions = exchange.currencyConversions
                
                var sqlExchange = SQLExchange(name: name, currencyConversions: currencyConversions)
                
                do {
                    try sqlExchange.insert(db)
                } catch {
                    print(error)
                }
            }
        }
    }
}
