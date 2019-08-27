//
//  SelectFiatService.swift
//  CryptoManager
//
//  Created by Jonny Caley on 20/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import SQLite
import RxSwift

class SelectFiatService {
    
    func getFiats() -> Single<[SQLFiat]> {
        return SQLiteDataBase.sharedInstance.getFiats()
    }
    
    func setBaseFiat(chosenFiat: SQLFiat) -> Completable{
        return SQLiteDataBase.sharedInstance.setBaseFiat(chosenFiat: chosenFiat)
    }
    
}
