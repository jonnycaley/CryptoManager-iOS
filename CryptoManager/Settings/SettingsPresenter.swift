//
//  SettingsPresenter.swift
//  CryptoManager
//
//  Created by Jonny Caley on 05/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

class SettingsPresenter {
    
    private let settingsService: SettingsService //model
    weak private var settingsViewDelegate: SettingsViewDelegate? //view functions
    
    init(settingsService: SettingsService){
        self.settingsService = settingsService
    }
    
    func setViewDelegate(settingsViewDelegate: SettingsViewDelegate?) {
        self.settingsViewDelegate = settingsViewDelegate
    }
    
    func getSettings() {
        
        let settingsList = settingsService.getSettings()
        
        self.settingsViewDelegate?.displaySettings(settings: settingsList)
        
    }
}
