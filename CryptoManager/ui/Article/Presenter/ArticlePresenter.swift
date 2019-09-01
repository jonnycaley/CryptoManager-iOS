//
//  ArticlePresenter.swift
//  CryptoManager
//
//  Created by Jonny Caley on 30/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import RxSwift

class ArticlePresenter {
    weak private var articleViewDelegate: ArticleViewDelegate?
    
    let disposeBag = DisposeBag()
    
    func setViewDelegate(articleViewDelegate: ArticleViewDelegate) {
        self.articleViewDelegate = articleViewDelegate
    }
    
    func attachView() {
        SQLiteDataBase.sharedInstance.getSavedArticleCount(articleId: articleViewDelegate?.getArticleId() ?? "")
            .subscribe{ event in
                switch event {
                case .success(let count):
                    switch count {
                    case 0: self.articleViewDelegate?.showOutlinedBookmarkIcon()
                    default: self.articleViewDelegate?.showFilledBookmarkIcon()
                    }
                case .error(let error):
                    print(error)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func addArticleToBookmarks(article: SQLArticle) {
        SQLiteDataBase.sharedInstance.sqlInsertSavedArticle(article: article)
            .subscribe{ event in
                switch event {
                case .error(let error):
                    print(error)
                case .completed:
                    print("added:", article.id)
                }
            }
            .disposed(by: disposeBag)
    }
    
    func removeArticleFromBookmarks(articleId: String) {
        SQLiteDataBase.sharedInstance.sqlRemoveSavedArticle(articleId: articleId)
            .subscribe{ event in
                switch event {
                case .error(let error):
                    print(error)
                case .completed:
                    print("removed:", articleId)
                }
            }
            .disposed(by: disposeBag)
    }
}
