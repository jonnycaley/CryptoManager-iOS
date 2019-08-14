//
//  SettingsSection.swift
//  CryptoManager
//
//  Created by Jonny Caley on 07/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

protocol SectionType: CustomStringConvertible {
    var containsSwitch: Bool { get }
}

enum SettingsSection: Int, CaseIterable, CustomStringConvertible {
    case General
    case Data
    case About
    
    var description: String {
        switch self {
        case .General: return "General"
        case .Data: return "Data"
        case .About: return "About"
        }
    }
}

enum GeneralOptions : Int, CaseIterable, SectionType {
    case SelectBaseCurrency
    case NightMode
    
    var containsSwitch: Bool {
        switch self {
        case .SelectBaseCurrency: return false
        case .NightMode: return true
        }
    }
    
    var description: String {
        switch self {
        case .SelectBaseCurrency: return "Select Base Currency"
        case .NightMode: return "Night Mode"
        }
    }
}

enum DataOptions : Int, CaseIterable, SectionType {
    case BookmarkedArticles
    case FullTransactionHistory
    case DeleteAllArticles
    case DeletePortfolio
    
    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .BookmarkedArticles: return "Bookmarked Articles"
        case .FullTransactionHistory: return "Full Transaction History"
        case .DeleteAllArticles: return "Delete All Articles"
        case .DeletePortfolio: return "Delete Portfolio"
        }
    }
}

enum AboutOptions : Int, CaseIterable, SectionType {
    case ReviewThisApp
    case ShareThisApp
    case SendFeedback
    case CurrencyPredictor
    case Version

    var containsSwitch: Bool { return false }
    
    var description: String {
        switch self {
        case .ReviewThisApp: return "Review This App"
        case .ShareThisApp: return "Share This App"
        case .SendFeedback: return "Send Feedback"
        case .CurrencyPredictor: return "Currency Predictor"
        case .Version: return "Version"
        }
    }
}
