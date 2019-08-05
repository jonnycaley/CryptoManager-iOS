//
//  SettingsViewDelegate.swift
//  CryptoManager
//
//  Created by Jonny Caley on 05/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

protocol SettingsViewDelegate: NSObjectProtocol {
    
    func displaySettings(settings:(Array<String>))
    
}
