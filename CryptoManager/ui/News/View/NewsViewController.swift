//
//  NewsViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 04/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import FaveButton

class NewsViewController: UIViewController, ThemeChangeProtocol, NewsViewDelegate, BookmarkChangedProtocol {
    
    var themeChangeDelegate: ThemeChangeProtocol?
    
    private var newsPresenter = NewsPresenter(newsService: NewsService())
    
    var bookmakChangedDelegate: BookmarkChangedProtocol?
    
    var statusBar: UIView!
    var loadingOverlay: UIActivityIndicatorView!
    
    var mainView: MainView!
    
    var topArticle: Article!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
        
        configureUI()
        
        newsPresenter.setViewDelegate(newsViewDelegate: self)
        
        newsPresenter.attachView()
    }
    
    func loadTopArticle(news: Article, isSaved: Bool) {
        topArticle = news
        mainView = MainView()
        view.addSubview(mainView)
        
        guard let urlStr = news.originalImageURL else { return }
        guard let imageUrl = URL(string: urlStr) else { return }
        guard let data = try? Data(contentsOf: imageUrl) else { return }
            
        mainView.headerImage.image = UIImage(data: data)
        mainView.titleText.text = news.title
        mainView.readLengthText.text = newsPresenter.getReadLength(wordsCount: news.words)
        
        if isSaved {
            mainView.bookmarkButton.setImage(UIImage(named: "bookmark_filled_white"), for: .normal)
        } else {
            mainView.bookmarkButton.setImage(UIImage(named: "bookmark_outline_white"), for: .normal)
        }
        
        guard let publishedAtStr = news.publishedAt else { return }
        mainView.dateText.text = " • " + newsPresenter.getDate(dateStr: publishedAtStr)
                        
        mainView.anchor(top: statusBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, centerX:
            nil, centerY: nil)
        
        mainView.delegate = self
    }
    
    func hideLoadingScreen() {
        loadingOverlay.removeFromSuperview()
    }
    
    func configureUI() {
        
        statusBar = StatusBarCover()
        view.addSubview(statusBar) //has to happen after configureTableView
        
        loadingOverlay = LoadingOverlay.init(style: .whiteLarge)
        view.addSubview(loadingOverlay)
        
        loadingOverlay.anchor(top: statusBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, centerX: nil, centerY: nil)
    }
    
    func addTopArticleToBookmarks() {
        newsPresenter.addArticleToBookmarks(article: topArticle)
    }
    
    func removeTopArticleFromBookmarks() {
        newsPresenter.removeArticleFromBookmarks(article: topArticle)
    }
    
    func onThemeChanged() {
        configureUI()
    }
}
