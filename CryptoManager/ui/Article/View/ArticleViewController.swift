//
//  ArticleViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 30/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit

class ArticleViewController: UIViewController, ArticleViewOnClickProtocol, ArticleViewDelegate {
    
    private var articlePresenter = ArticlePresenter()
    
    var article: SQLArticle!
    
    let navigationBar = Bar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Theme.current.backgroundSecondary
        
        hideNavigationBar()
        addNavigationBar()
        addStatusHeader()
        Utils.configureStatusBarColor()
        addWebView()
        
        articlePresenter.setViewDelegate(articleViewDelegate: self)
        articlePresenter.attachView()
    }
    
    func addWebView() {
        
        let webView = WebView(url: article.url)
        
        view.addSubview(webView)
        webView.anchor(top: navigationBar.bottomAnchor, leading: self.view.leadingAnchor, bottom: self.view.bottomAnchor, trailing: self.view.trailingAnchor, centerX: nil, centerY: nil)
    }
    
    func onBackPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func addStatusHeader() {
        view.addSubview(StatusBarCover())
    }
    
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    func addNavigationBar() {
        navigationBar.articleClickDelegate = self
        view.addSubview(navigationBar)
        navigationBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, centerX: nil, centerY: nil)
    }
    
    func showOutlinedBookmarkIcon() {
        navigationBar.createBookmarkBarButton(isFilled: false)
    }
    
    func showFilledBookmarkIcon() {
        navigationBar.createBookmarkBarButton(isFilled: true)
    }
    
    
    func addArticleToBookmarks() {
        articlePresenter.addArticleToBookmarks(article: article)
    }
    
    func removeArticleFromBookmarks() {
        articlePresenter.removeArticleFromBookmarks(articleId: article.id)
    }
    
    func getArticleId() -> String {
        return article.id
    }
    
}


extension ArticleViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
