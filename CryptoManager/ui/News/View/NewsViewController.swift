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

class NewsViewController: UIViewController, ThemeChangeProtocol, NewsViewDelegate {
    
    private var newsPresenter = NewsPresenter(newsService: NewsService())
    
    var statusBar: UIView!
    var loadingOverlay: UIActivityIndicatorView!
    
    var mainView: NewsView!
    
    var topArticle: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
        
        configureUI()
        
        newsPresenter.setViewDelegate(newsViewDelegate: self)
        newsPresenter.attachView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        newsPresenter.updateSavedArticles()
    }
    
    func loadTopArticle(news: Article, isSaved: Bool) {
        topArticle = news
        mainView = NewsView()
        view.addSubview(mainView)

        guard let urlStr = news.originalImageURL else { return }
        guard let imageUrl = URL(string: urlStr) else { return }
        guard let data = try? Data(contentsOf: imageUrl) else { return }

        mainView.headerImage.image = UIImage(data: data)
        mainView.titleText.text = news.title
        mainView.readLengthText.text = news.words?.getReadLength()

        if isSaved {
            mainView.bookmarkButton.setImage(UIImage(named: "bookmark_filled_black"), for: .normal)
        } else {
            mainView.bookmarkButton.setImage(UIImage(named: "bookmark_outline_black"), for: .normal)
        }

        guard let publishedAtStr = news.publishedAt else { return }
        mainView.dateText.text = " • " + newsPresenter.getDate(dateStr: publishedAtStr)

        mainView.anchor(top: statusBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, centerX:
            nil, centerY: nil)
        mainView.delegate = self
    }
    
    func hideLoadingOverlay() {
        loadingOverlay.removeFromSuperview()
    }
    
    func configureUI() {
        addStatusBar()
        addLoadingOverlay()
    }
    
    func addStatusBar() {
        statusBar = StatusBarCover()
        view.addSubview(statusBar) //has to happen after configureTableView
    }
    
    func addLoadingOverlay() {
        loadingOverlay = LoadingOverlay.init(style: .whiteLarge)
        view.addSubview(loadingOverlay)
        loadingOverlay.anchor(top: statusBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, centerX: nil, centerY: nil)
    }
    
    func onThemeChanged() {
        addStatusBar()
        if loadingOverlay.isDescendant(of: view) {
            hideLoadingOverlay()
            addLoadingOverlay()
        } else { 
            mainView.updateTheme()
        }
    }
    
}

extension NewsViewController: MainViewOnClickProtocol {
    
    func openHeaderArticle() {
        let controller = ArticleViewController()
        
        var sqlArticle = topArticle?.convertToSQLArticle()
        controller.article = sqlArticle
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func addTopArticleToBookmarks() {
        guard let article = topArticle else { return }
        newsPresenter.addArticleToBookmarks(article: article)
    }
    
    func removeTopArticleFromBookmarks() {
        guard let article = topArticle else { return }
        newsPresenter.removeArticleFromBookmarks(article: article)
    }
}
