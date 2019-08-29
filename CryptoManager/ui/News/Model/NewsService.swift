//
//  NewsService.swift
//  CryptoManager
//
//  Created by Jonny Caley on 28/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import RxSwift

class NewsService {
    func getNews() -> Single<Articles> {
        return CryptoControlService.shared.getTopNews()
    }
    
    func getSavedArticles() -> Single<[SQLArticle]> {
        return SQLiteDataBase.sharedInstance.getSavedArticles()
    }
    
    func getSavedArticleCount(article: Article) -> Single<Int> {
        return SQLiteDataBase.sharedInstance.getSavedArticleCount(article: article)
    }
    
    func saveArticle(article: Article) -> Completable {
        return SQLiteDataBase.sharedInstance.sqlInsertSavedArticle(article: article)
    }
    
    func removeArticleFromBookmarks(article: Article) -> Completable {
        return SQLiteDataBase.sharedInstance.sqlRemoveSavedArticle(article: article)
    }
}
