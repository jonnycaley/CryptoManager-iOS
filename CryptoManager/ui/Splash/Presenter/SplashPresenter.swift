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
        splashService.loadDatabase()
        
        if(splashService.createFiatsTable()){
            print("loading base fiats")
            loadBaseFiats()
        }
        if(splashService.createCryptoTable()){
            print("loading cryptos")
            loadCryptoCurrencies()
        }
        if(splashService.createExchangesTable()){
            print("loading exchanges")
            loadExchanges()
        }
        
        self.splashViewDelegate?.toMainTabActivity()
    }
    
    func loadBaseFiats() {
        splashService.getExchangeRates()
            .subscribe { event in
                switch event {
                case .success(let json):
                    var fiats = [Fiat]()
                    json.rates.forEach({ (arg0) in
                        let (key, value) = arg0
                        fiats.append(Fiat.init(fiat: key, rate: value, isBaseRate: (key == "GBP")))
                    })
                    self.splashService.sqlLoadFiats(fiats: fiats)
                case .error(let error):
                    print("Error: ", error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func loadCryptoCurrencies() {
        splashService.getCryptoCurrencies()
            .subscribe { event in
                switch event {
                case .success(let json):
                    self.splashService.sqlLoadCrypto(cryptos: json)
                case .error(let error):
                    print("Error: ", error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func loadExchanges() {
        splashService.getExchanges()
            .subscribe { event in
                switch event {
                case .success(let json):
                    var formattedExchanges = self.formatExchanges(str: json)
                    self.splashService.sqlLoadExchanges(exchanges: formattedExchanges)
                case .error(let error):
                    print("Error: ", error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func formatExchanges(str: String) -> [SQLExchange]? {
        
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
//                    print("Exchange", exchange.exchange)
//                    print("Currencies")
                    var currencyAndConverters = [String: [String]]()
            
                    exchange.currencyConversions.forEach({ (currencyAndConversions) in
                        currencyAndConverters[currencyAndConversions.base] = currencyAndConversions.rates
//                        print(CurrencyAndConversions.base)
//                        print(CurrencyAndConversions.rates)
                    })
                    
                    sqlExchanges.append(SQLExchange.init(exchange: exchange.exchange, currencyConversions: currencyAndConverters.description))
                }
                
                sqlExchanges.forEach { (exchange) in
                    print(exchange.exchange)
                    print(exchange.currencyConversions)
                }
                
                return sqlExchanges
                
                //TODO: CREATE AND SAVE THE VALUES TO THE EXCHANGES TABLE WOOOOO
            }
        } catch {
            print(error)
        }
        return nil
    }
}
