//
//  Bar.swift
//  CryptoManager
//
//  Created by Jonny Caley on 19/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit

class Bar: UINavigationBar {
    
    var articleClickDelegate: ArticleViewOnClickProtocol?
    
    var bookmarkBarButton: UIBarButtonItem?
    var bookmarkButtonImage: UIImage?

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isTranslucent = false
        self.barTintColor = Theme.current.background
        
        //enables autolayout
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage()
        let navButton = navItem
        createBackBarButton(navigationItem: navButton)
        
        self.items = [navButton]
    }
    
    func createBackBarButton(navigationItem:UINavigationItem){
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    func createBookmarkBarButton(isFilled: Bool) {
        let navigationItem = navItem
        bookmarkBarButton = UIBarButtonItem(customView: generateBookmarkButton(isFilled: isFilled))
        bookmarkBarButton?.customView?.heightAnchor.constraint(equalToConstant: 25).isActive = true
        bookmarkBarButton?.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
        navigationItem.rightBarButtonItem = bookmarkBarButton
    }
    
    func generateBookmarkButton(isFilled: Bool) -> UIButton  {
        bookmarkButtonImage = UIImage(named: "bookmark_outline_black")
        if isFilled {
            bookmarkButtonImage = UIImage(named: "bookmark_filled_black")
        }
        let tintedImage = bookmarkButtonImage?.withRenderingMode(.alwaysTemplate)

        let bookmarkButton = UIButton(frame: .zero)
        bookmarkButton.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        bookmarkButton.setImage(tintedImage!, for: .normal)
        bookmarkButton.tintColor = Theme.current.icons
        
        return bookmarkButton
    }
    
    lazy var backButton: UIButton = {
        let backButtonImage = UIImage(named: "arrow_back_black")
        let tintedImage = backButtonImage?.withRenderingMode(.alwaysTemplate)
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: backButtonImage!.size.width, height: backButtonImage!.size.height))
        backButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        backButton.setImage(tintedImage!, for: .normal)
        backButton.tintColor = Theme.current.icons
        
        return backButton
    }()
    
    lazy var navItem : UINavigationItem = {
        let navItem = UINavigationItem()
        return navItem
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Bar {
    @objc func backBarButtonTapped() {
        self.articleClickDelegate?.onBackPressed()
    }
    
    @objc func bookmarkButtonTapped() {
        switch bookmarkButtonImage {
        case UIImage(named: "bookmark_outline_black"):
            print("shouldBeOutlined")
            self.articleClickDelegate?.addArticleToBookmarks()
            createBookmarkBarButton(isFilled: true)
        default:
            print("shouldBeFilled")
            self.articleClickDelegate?.removeArticleFromBookmarks()
            createBookmarkBarButton(isFilled: false)
        }
    }
}

protocol ArticleViewOnClickProtocol {
    func onBackPressed()
    func addArticleToBookmarks()
    func removeArticleFromBookmarks()
}
