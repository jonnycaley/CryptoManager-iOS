//
//  SplashService.swift
//  CryptoManager
//
//  Created by Jonny Caley on 09/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire
import SQLite

class SplashService {
    
    enum NewtorkFailureReason: Int, Error {
        case unAuthorized = 401
        case notFound = 404
    }
    
    func getExchangeRates() -> Single<Rates> {
        
        return Single.create { single -> Disposable in
            
            AF.request(Constants.EXCHANGERATES_URL)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            // if no error provided by alamofire return .notFound error instead.
                            // .notFound should never happen here?
                            single(.error(response.error ?? NewtorkFailureReason.notFound))
                            return
                        }
                        do {
                            let response = try JSONDecoder().decode(Rates.self, from: data)
                            single(.success(response))
                        } catch {
                            single(.error(error))
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                            let reason = NewtorkFailureReason(rawValue: statusCode)
                        {
                            single(.error(reason))
                        }
                        single(.error(error))
                    }
            }
            return Disposables.create()
        }
    }
    
    func getCryptoCurrencies() -> Single<Crypto> {
        
        return Single.create { single -> Disposable in
            
            AF.request(Constants.CRYPTOCOMPARE_URL,
                       method: .get,
                       parameters: [Constants.CRYPTOCOMPARE_NAME: Constants.CRYPTOCOMPARE_KEY],
                       encoding: URLEncoding(destination: .queryString),
                       headers: nil)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .success:
                        guard let data = response.data else {
                            // if no error provided by alamofire return .notFound error instead.
                            // .notFound should never happen here?
                            single(.error(response.error ?? NewtorkFailureReason.notFound))
                            return
                        }
                        do {
                            let response = try JSONDecoder().decode(Crypto.self, from: data)
                            single(.success(response))
                        } catch {
                            single(.error(error))
                        }
                    case .failure(let error):
                        if let statusCode = response.response?.statusCode,
                            let reason = NewtorkFailureReason(rawValue: statusCode)
                        {
                            single(.error(reason))
                        }
                        single(.error(error))
                    }
            }
            return Disposables.create()
        }
    }
    
    var database: Connection!
    
    func loadDatabase() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("fiats").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
        
    let fiatsTable = Table("fiats")
    
    let fiat = Expression<String>("fiat")
    let rate = Expression<Double>("rate")
    
    func createFiatsTable() -> Bool {
        let createTable = self.fiatsTable.create { (table) in
            table.column(self.fiat, primaryKey: true)
            table.column(self.rate)
        }
        do {
            try self.database.run(createTable)
            return true
        } catch {
            //table already exists
            print(error)
            return false
        }
    }
    
    func sqlLoadFiats(fiats: [String : Double]) {
        
        fiats.forEach { (fiat) in
            let (key, value) = fiat
            let insertFiat = self.fiatsTable.insert(self.fiat <- key, self.rate <- value)
            do {
                try self.database.run(insertFiat)
                print("inserted fiat")
            } catch {
                print(error)
            }
        }
    }
    
    let cryptoTable = Table("Cryptos")

    let id = Expression<String>("id")
    let imageUrl = Expression<String>("imageUrl")
    let linkUrl = Expression<String>("linkUrl")
    let name = Expression<String>("name")
    let symbol = Expression<String>("symbol")
    let coinName = Expression<String>("coinName")
    let fullName = Expression<String>("fullName")
    let sortOrder = Expression<String>("sortOrder")
    
    func createCryptoTable() -> Bool {
        let createTable = self.cryptoTable.create { (table) in
            table.column(self.id, primaryKey: true)
            table.column(self.imageUrl)
            table.column(self.linkUrl)
            table.column(self.name)
            table.column(self.symbol)
            table.column(self.coinName)
            table.column(self.fullName)
            table.column(self.sortOrder)
        }
        do {
            try self.database.run(createTable)
            return true
        } catch {
            print(error)
            return false
        }
    }
    
    func sqlLoadCrypto(cryptos: Crypto) {
        
        cryptos.data.forEach { (crypto) in
            
            let id = crypto.value.id
            let imageUrl = crypto.value.imageURL.map { cryptos.baseImageURL + $0 }
            let linkUrl = cryptos.baseLinkURL + crypto.value.url
            let name = crypto.value.name
            let symbol = crypto.value.symbol
            let coinName = crypto.value.coinName
            let fullName = crypto.value.fullName
            let sortOrder = crypto.value.sortOrder
            
            let insertCrypto = self.cryptoTable.insert(
                self.id <- id,
                self.imageUrl <- imageUrl ?? "",
                self.linkUrl <- linkUrl,
                self.name <- name,
                self.symbol <- symbol,
                self.coinName <- coinName,
                self.fullName <- fullName,
                self.sortOrder <- sortOrder)
            do {
                try self.database.run(insertCrypto)
                print("inserted crypto")
            } catch {
                print(error)
            }
        }
    }
    
    func listSqlCrypto() {
        do {
            let cryptos = try self.database.prepare(self.cryptoTable)
            for crypto in cryptos {
                print(crypto[self.coinName])
            }
        } catch {
            print(error)
        }
    }
}
