//
//  SettingsPresenter.swift
//  CryptoManager
//
//  Created by Jonny Caley on 05/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import RxSwift

class SettingsPresenter {
    
    private let settingsService: SettingsService //model
    weak private var settingsViewDelegate: SettingsViewDelegate? //view functions
    
    let disposeBag = DisposeBag()
    
    init(settingsService: SettingsService){
        self.settingsService = settingsService
    }
    
    func setViewDelegate(settingsViewDelegate: SettingsViewDelegate?) {
        self.settingsViewDelegate = settingsViewDelegate
    }
    
    func getSettings() {
        
        settingsService.getBaseFiat()
            .subscribe { event in
                switch event {
                case .success(let json):
                    self.settingsViewDelegate?.displaySettings(settings: self.settingsService.getSettings(), baseFiat: json)
                    print(json.name)
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
}
