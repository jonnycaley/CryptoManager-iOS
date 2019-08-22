//
//  SelectFiatService.swift
//  CryptoManager
//
//  Created by Jonny Caley on 20/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import SQLite

class SelectFiatService {
    
    var database: Connection!
    
    func loadDatabase() {
        do {
            let documentDirectory = try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let fileUrl = documentDirectory.appendingPathComponent("fiats").appendingPathExtension("sqlite3")
            let database = try Connection(fileUrl.path)
            self.database = database
        } catch {
            print(error)
        }
    }
    
    let fiatsTable = Table("fiats")
    
    let fiat = Expression<String>("fiat")
    let rate = Expression<Double>("rate")
    let isBaseFiat = Expression<Bool>("isBaseFiat")

    func getFiats() -> [Fiat] {
        var fiats = [Fiat]()
        do {
            for fiat in try self.database.prepare(self.fiatsTable) {
                let newFiat = Fiat(fiat: fiat[self.fiat], rate: fiat[self.rate], isBaseRate: fiat[self.isBaseFiat])
                fiats.append(newFiat)
            }
        } catch {
            print(error)
        }
        return fiats
    }
    
}
