//
//  CryptoCompareService.swift
//  CryptoManager
//
//  Created by Jonny Caley on 28/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire

enum NewtorkFailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
}

class CryptoCompareService: NSObject {
    
    static let shared = CryptoCompareService()
    
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
}
