//
//  NewsPresenter.swift
//  CryptoManager
//
//  Created by Jonny Caley on 28/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import RxSwift

class NewsPresenter {
    private let newsService: NewsService
    weak private var newsViewDelegate: NewsViewDelegate?
    
    let disposeBag = DisposeBag()
    
    init(newsService: NewsService) {
        self.newsService = newsService
    }
    
    func setViewDelegate(newsViewDelegate: NewsViewDelegate?) {
        self.newsViewDelegate = newsViewDelegate
    }
    
    func attachView() {
        //start stuff here
        newsService.getNews()
            .subscribe{ event in
                switch event {
                case .success(let news):
                    news.forEach{ newsItem in
                        print(newsItem.newsDescription)
                    }
                case .error(let error):
                    debugPrint(error)
                    print(error.localizedDescription)
                }
        }.disposed(by: disposeBag)
    }
}
