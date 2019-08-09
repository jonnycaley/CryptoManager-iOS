//
//  SplashPresenter.swift
//  CryptoManager
//
//  Created by Jonny Caley on 09/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

class SplashPresenter {
    
    private let splashService: SplashService //model
    weak private var splashViewDelegate: SplashViewDelegate? //view functions
    
    init(splashService : SplashService) {
        self.splashService = splashService
    }
    
    func setViewDelegate(splashViewDelegate: SplashViewDelegate?) {
        self.splashViewDelegate = splashViewDelegate
    }
    
    func getBaseCurrencies() {
        splashService.getExchangeRates()
    }
    
}
