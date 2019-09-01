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
    
    func getSavedArticleCount(articleId: String) -> Single<Int> {
        return SQLiteDataBase.sharedInstance.getSavedArticleCount(articleId: articleId)
    }
    
    func saveArticle(article: SQLArticle) -> Completable {
        return SQLiteDataBase.sharedInstance.sqlInsertSavedArticle(article: article)
    }
    
    func removeArticleFromBookmarks(articleId: String) -> Completable {
        return SQLiteDataBase.sharedInstance.sqlRemoveSavedArticle(articleId: articleId)
    }
}
