//
//  Extensions.swift
//  CryptoManager
//
//  Created by Jonny Caley on 29/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    // For insert layer in Foreground
    func addBlackGradientLayerInForeground(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
    }
}

extension String {
    func getFiatName() -> String {
        switch self {
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

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = image?.withRenderingMode(.alwaysTemplate)
        image = templateImage
        tintColor = color
    }
}

extension Date {
    func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))
        
        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day
        
        if secondsAgo < minute {
            if secondsAgo == 1 {
                return "\(secondsAgo) second ago"
            } else {
                return "\(secondsAgo) seconds ago"
            }
        } else if secondsAgo < hour {
            if (secondsAgo / minute) == 1 {
                return "\(secondsAgo / minute) minute ago"
            } else {
                return "\(secondsAgo / minute) minutes ago"
            }
        } else if secondsAgo < day {
            if (secondsAgo / hour) == 1 {
                return "\(secondsAgo / hour) hour ago"
            } else {
                return "\(secondsAgo / hour) hours ago"
            }
        } else if secondsAgo < week {
            if (secondsAgo / hour) == 1 {
                return "\(secondsAgo / day) day ago"
            } else {
                return "\(secondsAgo / day) days ago"
            }
        }
        if (secondsAgo / week) == 1 {
            return "\(secondsAgo / week) week ago"
        } else {
            return "\(secondsAgo / week) weeks ago"
        }
    }
}
