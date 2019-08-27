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
            
            AF.request(Constants.CRYPTOCOMPARE_URL + Constants.CRYPTOCOMPARE_ALLCRYPTO,
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
        
        return Single.create { single -> Disposable in
            
            AF.request(Constants.CRYPTOCOMPARE_URL + Constants.CRYPTOCOMPARE_ALLEXCHANGES,
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
                            let response = String(data: data, encoding: .utf8)
                            single(.success(response ?? ""))
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
}
