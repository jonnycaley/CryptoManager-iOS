//
//  SelectBaseFiatPresenter.swift
//  CryptoManager
//
//  Created by Jonny Caley on 20/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

class SelectFiatPresenter {
    
    private let selectFiatService: SelectFiatService //model
    weak private var selectFiatViewDelegate: SelectFiatViewDelegate?
    
    init(selectFiatService: SelectFiatService) {
        self.selectFiatService = selectFiatService
    }
    
    func setViewDelegate(selectFiatViewDelegate: SelectFiatViewDelegate?) {
        self.selectFiatViewDelegate = selectFiatViewDelegate
    }
    
    func onInit() {
        selectFiatService.loadDatabase()
        
        let fiats = selectFiatService.getFiats()
        
        self.selectFiatViewDelegate?.loadFiats(fiats: fiats)
    }
}
