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
            .map{ (newsItems) -> News in
                newsItems.filter { $0.originalImageURL != nil }.sorted(by: { $0.publishedAt ?? "" > $1.publishedAt ?? "" })
            }
            .subscribe{ event in
                switch event {
                case .success(let news):
                    self.newsViewDelegate?.loadTopArticle(news: news.first { $0.originalImageURL != nil }! )
                    self.newsViewDelegate?.hideLoadingScreen()
                case .error(let error):
                    debugPrint(error)
                    print(error.localizedDescription)
                }
        }.disposed(by: disposeBag)
    }
}
