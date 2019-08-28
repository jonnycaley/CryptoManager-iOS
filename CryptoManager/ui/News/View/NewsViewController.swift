//
//  NewsViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 04/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, ThemeChangeProtocol, NewsViewDelegate {
    
    var themeChangeDelegate: ThemeChangeProtocol?
    
    private var newsPresenter = NewsPresenter(newsService: NewsService())
    
    var statusBar: UIView!
    var loadingOverlay: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        newsPresenter.setViewDelegate(newsViewDelegate: self)
        newsPresenter.attachView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
    }
    
    func configureUI() {
        statusBar = StatusBarCover()
        view.addSubview(statusBar) //has to happen after configureTableView
        
        loadingOverlay = LoadingOverlay.init(style: .whiteLarge)
        view.addSubview(loadingOverlay)
        
        loadingOverlay.anchor(top: statusBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, centerX: nil, centerY: nil)
    }
    
    func onThemeChanged() {
        print("NewsViewController onThemeChanged")
        configureUI()
    }
}
