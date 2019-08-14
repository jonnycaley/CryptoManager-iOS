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
            
        }
    }
    
    func loadBaseFiats() {
        
        splashService.getExchangeRates()
            .subscribe { event in
                switch event {
                case .success(let json):
                    self.splashService.sqlLoadFiats(fiats: json.rates)
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
}
