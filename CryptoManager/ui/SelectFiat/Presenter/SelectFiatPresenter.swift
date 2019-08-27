//
//  SelectBaseFiatPresenter.swift
//  CryptoManager
//
//  Created by Jonny Caley on 20/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import RxSwift

class SelectFiatPresenter {
    
    private let selectFiatService: SelectFiatService //model
    weak private var selectFiatViewDelegate: SelectFiatViewDelegate?

    let disposeBag = DisposeBag()

    
    init(selectFiatService: SelectFiatService) {
        self.selectFiatService = selectFiatService
    }
    
    func setViewDelegate(selectFiatViewDelegate: SelectFiatViewDelegate?) {
        self.selectFiatViewDelegate = selectFiatViewDelegate
    }
    
    func onInit() {
        selectFiatService.getFiats()
            .subscribe { event in
                switch event {
                case .success(let fiats):
                    self.selectFiatViewDelegate?.loadFiats(fiats: fiats)
                
                case .error(let error):
                    print("Error: ", error)
                }
        }.disposed(by: disposeBag)
    }
    
    func setBaseFiat(chosenFiat: SQLFiat) {
        selectFiatService.setBaseFiat(chosenFiat: chosenFiat)
            .subscribe { event in
                switch event {
                case .completed:
                    print("Complete")
                case .error(let error):
                    print("Error: ", error)
                }
            }.disposed(by: disposeBag)
        
    }
}
