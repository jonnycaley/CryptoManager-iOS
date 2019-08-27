//
//  SettingsService.swift
//  CryptoManager
//
//  Created by Jonny Caley on 05/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

// plays the roll as the data provider

import Foundation
import RxSwift

class SettingsService {
    
    func getSettings() -> Array<String> {
        
        let settings = ["Select Base Currency", "Night Mode", "Saved Articles", "Full Transaction History", "Delete All Articles", "Delete Portfolio", "Review This App", "Share This App", "Send Feedback"]
        
        return settings
    }
    
    func getBaseFiat() -> Single<SQLFiat> {
        return SQLiteDataBase.sharedInstance.getBaseFiat()
    }
    
}
