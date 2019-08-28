//
//  NewsViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 04/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController, ThemeChangeProtocol, NewsViewDelegate {
    
    var customView: UIView!
    
    var themeChangeDelegate: ThemeChangeProtocol?
    
    private var newsPresenter = NewsPresenter(newsService: NewsService())

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        newsPresenter.setViewDelegate(newsViewDelegate: self)
        newsPresenter.attachView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func configureUI() {
        addStatusHeader() //has to happen after configureTableView
    }
    
    func addStatusHeader() {
        view.addSubview(StatusBarCover())
    }
    
    func onThemeChanged() {
        print("NewsViewController onThemeChanged")
        configureUI()
    }
}
