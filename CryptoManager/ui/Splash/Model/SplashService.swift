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
import SwiftyJSON

class SplashService {
    
    func getExchangeRates() -> Single<Rates> {
        return CryptoCompareService.shared.getExchangeRates()
    }
    
    func getCryptoCurrencies() -> Single<Crypto> {
        return CryptoCompareService.shared.getCryptoCurrencies()
    }

    func createFiatsTable() -> Single<Bool> {
        return SQLiteDataBase.sharedInstance.createFiatsTable()
    }
    
    func sqlLoadFiats(fiats: [SQLFiat]) -> Completable {
        return SQLiteDataBase.sharedInstance.sqlInsertFiats(fiats: fiats)
    }
    
    func createCryptoTable() -> Single<Bool> {
        return SQLiteDataBase.sharedInstance.createCryptoTable()
    }
    
    func sqlLoadCrypto(cryptos: Crypto) -> Completable{
        return SQLiteDataBase.sharedInstance.sqlInstertCrypto(cryptos: cryptos)
    }
    
    func createExchangesTable() -> Single<Bool> {
        return SQLiteDataBase.sharedInstance.createExchangesTable()
    }
    
    func sqlLoadExchanges(exchanges: [SQLExchange]) -> Completable {
        return SQLiteDataBase.sharedInstance.sqlInsertExchanges(exchanges: exchanges)
    }
    
    func getExchanges() -> Single<String> {
        return CryptoCompareService.shared.getExchanges()
    }
}
