//
//  Utils.swift
//  CryptoManager
//
//  Created by Jonny Caley on 20/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    static func configureStatusBarColor() {
        if(UserDefaults.standard.bool(forKey: "isDarkTheme")) {UIApplication.shared.statusBarStyle = .lightContent
        } else {UIApplication.shared.statusBarStyle = .default
        }
    }
}
