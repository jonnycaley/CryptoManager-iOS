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
    
    var mainView: MainView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.edgesForExtendedLayout = UIRectEdge()
        self.extendedLayoutIncludesOpaqueBars = false
        self.automaticallyAdjustsScrollViewInsets = false
        
        configureUI()
        
        newsPresenter.setViewDelegate(newsViewDelegate: self)
        newsPresenter.attachView()
    }
    
    func loadTopArticle(news: NewsElement) {
        mainView = MainView()
        view.addSubview(mainView)
        
        let imgUrl = URL(string: news.originalImageURL!)!
        let data = try? Data(contentsOf: imgUrl)
        mainView.headerImage.image = UIImage(data: data!)
        
        mainView.anchor(top: statusBar.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, centerX:
            nil, centerY: nil)
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
    
    func onThemeChanged() {
        configureUI()
    }
}

extension UIView{
    // For insert layer in Foreground
    func addBlackGradientLayerInForeground(frame: CGRect, colors:[UIColor]){
        let gradient = CAGradientLayer()
        gradient.frame = frame
        gradient.colors = colors.map{$0.cgColor}
        self.layer.addSublayer(gradient)
}
}
