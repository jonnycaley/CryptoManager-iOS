//
//  SplashPresenter.swift
//  CryptoManager
//
//  Created by Jonny Caley on 09/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SQLite
import SwiftyJSON


class SplashPresenter {
    
    private let splashService: SplashService //model
    weak private var splashViewDelegate: SplashViewDelegate? //view functions
    
    let disposeBag = DisposeBag()
    
    init(splashService : SplashService) {
        self.splashService = splashService
    }
    
    func setViewDelegate(splashViewDelegate: SplashViewDelegate?) {
        self.splashViewDelegate = splashViewDelegate
    }
    
    func onInit() {        
        splashService.createFiatsTable()
            .subscribe { event in
                switch event {
                case .success(let isTableCreated):
                    if(isTableCreated){
                        print("fiatTableCreated")
                        self.loadBaseFiats()
                    } else {
                        print("fiatIsTable NOT Created")
                    }
                case .error(let error):
                    print("Error: ", error)
                }
            }
            .disposed(by: disposeBag)
        
        splashService.createCryptoTable()
            .subscribe { event in
                switch event {
                case .success(let isTableCreated):
                    if(isTableCreated){
                        print("cryptoTableCreated")
                        self.loadCryptoCurrencies()
                    } else {
                        print("cryptoTable NOT Created")
                    }
                case .error(let error):
                    print("Error: ", error)
                }
            }
            .disposed(by: disposeBag)
        
        
        
        splashService.createExchangesTable()
            .subscribe { event in
                switch event {
                case .success(let isTableCreated):
                    if(isTableCreated){
                        print("exchangesTableCreated")
                        self.loadExchanges()
                    } else {
                        print("exchangesTable NOT Created")
                    }
                case .error(let error):
                    print("Error: ", error)
                }
            }
            .disposed(by: disposeBag)
        
        
        self.splashViewDelegate?.toMainTabActivity()
    }
    
    func loadBaseFiats() {
        splashService.getExchangeRates()
            .flatMapCompletable({ (json) -> Completable in
                var fiats = [SQLFiat]()
                json.rates.forEach({ (arg0) in
                    let (key, value) = arg0
                    fiats.append(SQLFiat.init(name: key, rate: value, isBaseFiat: (key == "GBP")))
                })
                return self.splashService.sqlLoadFiats(fiats: fiats)
            })
            .subscribe { event in
                switch event {
                case .completed:
                    print("completed")
                case .error(let error):
                    print("Error: ", error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func loadCryptoCurrencies() {
        splashService.getCryptoCurrencies()
            .flatMapCompletable({ (cryptos) -> Completable in
                self.splashService.sqlLoadCrypto(cryptos: cryptos)
            })
            .subscribe { event in
                switch event {
                case .completed:
                    print("Complete")
                case .error(let error):
                    print("Error: ", error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func loadExchanges() {
        splashService.getExchanges()
            .flatMapCompletable({ (json) -> Completable in
                var formattedExchanges = self.formatExchanges(str: json)
                 return self.splashService.sqlLoadExchanges(exchanges: formattedExchanges)
            })
            .subscribe { event in
                switch event {
                case .completed:
                    print("Success")
                case .error(let error):
                    print("Error: ", error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func formatExchanges(str: String) -> [SQLExchange] {
        
        do {
            if let dataFromString = str.data(using: .utf8, allowLossyConversion: false) {
                let json = try JSON(data: dataFromString)
                
                var exchanges = [Exchanges]()
                
                for (exchange, subJson1):(String, JSON) in json {
                    
                    var exchangeCurrencies = [CurrencyAndConversions]()
                    for (crypto, converters):(String, JSON) in subJson1 {
                        var convertersArr:[String] = converters.arrayValue.map { $0.stringValue}
                        exchangeCurrencies.append(CurrencyAndConversions.init(base: crypto, rates: convertersArr))
                    }
                    exchanges.append(Exchanges.init(exchange: exchange, currencyConversions: exchangeCurrencies))
                }
                var sqlExchanges = [SQLExchange]()
                
                exchanges.forEach { (exchange) in
                    var currencyAndConverters = [String: [String]]()
            
                    exchange.currencyConversions.forEach({ (currencyAndConversions) in
                        currencyAndConverters[currencyAndConversions.base] = currencyAndConversions.rates
                    })
                    
                    sqlExchanges.append(SQLExchange.init(name: exchange.exchange, currencyConversions: currencyAndConverters.description))
                }
                return sqlExchanges
            }
        } catch {
            print(error)
        }
        return [SQLExchange]()
    }
}
