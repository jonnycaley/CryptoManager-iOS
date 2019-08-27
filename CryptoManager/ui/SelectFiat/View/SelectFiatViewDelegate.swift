//
//  SelectFiatViewDelegate.swift
//  CryptoManager
//
//  Created by Jonny Caley on 20/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

protocol SelectFiatViewDelegate: NSObjectProtocol {
    func loadFiats(fiats: [SQLFiat])
}
