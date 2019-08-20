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
    
    static func getFiatName(fiat: String?) -> String {
        switch fiat {
        case "AUD" : return "Australian Dollar"
        case "BGN" : return "Bulgarian Lev"
        case "BRL" : return "Brazilian Real"
        case "CAD" : return "Canadian Dollar"
        case "CHF" :return "Swiss Franc"
        case "CNY" :return "Chinese Yuan"
        case "CZK" :return "Czech Koruna"
        case "DKK" :return "Danish Krone"
        case "GBP" :return "Pound sterling"
        case "HKD" :return "Hong Kong Dollar"
        case "HRK" :return "Croatian Kuna"
        case "HUF" :return "Hungarian Forint"
        case "IDR" :return "Indonesian Rupiah"
        case "ILS" :return "Israeli New Shekel"
        case "INR" :return "Indian Rupee"
        case "ISK" :return "Icelandic Króna"
        case "JPY" :return "Japanese Yen"
        case "KRW" :return "South Korean won"
        case "MXN" :return "Mexican Peso"
        case "MYR" :return "Malaysian Ringgit"
        case "NOK" :return "Norwegian Krone"
        case "NZD" :return "New Zealand Dollar"
        case "PHP" :return "Philippine Piso"
        case "PLN" :return "Poland złoty"
        case "RON" :return "Romanian Leu"
        case "RUB" :return "Russian Ruble"
        case "SEK" :return "Swedish Krona"
        case "SGD" :return "Singapore Dollar"
        case "THB" :return "Thai Baht"
        case "TRY" :return "Turkish lira"
        case "ZAR" :return "South African Rand"
        case "USD" :return "United States Dollar"
        case "EUR" :return "Euro"
        default: return ""
        }
    }
    
}
