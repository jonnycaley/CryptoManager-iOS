//
//  SplashService.swift
//  CryptoManager
//
//  Created by Jonny Caley on 09/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

class SplashService {
    
    func getExchangeRates() -> String {
        let url = "https://api.exchangeratesapi.io/latest?base=USD"
        return url
    }
}
