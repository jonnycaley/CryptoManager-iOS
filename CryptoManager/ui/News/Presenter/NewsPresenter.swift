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
        
        Single.zip(newsService.getNews(), newsService.getSavedArticles(), resultSelector: { news, savedArticles in
            
            guard let headerItem = (news.filter { $0.originalImageURL != nil }.sorted(by: { $0.publishedAt ?? "" > $1.publishedAt ?? "" }).first) else { return }
//            var remainderItems = news.filter { $0.id != headerItem.id }.sorted(by: { $0.publishedAt ?? "" > $1.publishedAt ?? "" })
            
            self.newsViewDelegate?.loadTopArticle(news: headerItem, isSaved: (savedArticles.filter{ $0.id == headerItem.id }.count > 0))
        }).observeOn(MainScheduler.instance)
            .subscribe{ event in
                switch event {
                case .success(_):
                    self.newsViewDelegate?.hideLoadingScreen()
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func addArticleToBookmarks(article: Article) {
        
        newsService.getSavedArticleCount(article: article)
            .filter{ $0 == 0}
            .asObservable()
            .flatMap{ _ -> Completable in self.newsService.saveArticle(article: article) }
            .subscribe{ event in
                switch event {
                case .error(let error):
                    print(error)
                case .completed:
                    print("addedarticle completed")
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    func removeArticleFromBookmarks(article: Article) {
        
        newsService.removeArticleFromBookmarks(article: article)
            .subscribe{ event in
                switch event {
                case .error(let error):
                    print(error)
                case .completed:
                    print("removedArticle Complete")
                }
            }
            .disposed(by: disposeBag)
        
    }
    
    func getReadLength(wordsCount: Int?) -> String {
        if(wordsCount == nil){
            return "1 min read"
        } else {
            return "\(String((wordsCount! - 1)/(130 + 1))) min read"
        }
    }
    
    func getDate(dateStr: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000'Z'"
        let date = dateFormatter.date(from: dateStr)
        
        return date?.timeAgoDisplay() ?? "just now"
    }
}
