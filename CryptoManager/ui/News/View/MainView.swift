//
//  HeaderView.swift
//  CryptoManager
//
//  Created by Jonny Caley on 28/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore
import FaveButton

class MainView: UIView {
    
    let headerHeight = 200
    let headerWidth = Int(UIScreen.main.bounds.size.width)
    
    var delegate: BookmarkChangedProtocol?
    
//    var article : Article!
    
//    required init(article: Article) {
//        super.init(frame: CGRect.zero)
//        self.article = article
//
//        self.backgroundColor = Theme.current.backgroundSecondary
//        self.translatesAutoresizingMaskIntoConstraints = false
//
//        setupViews()
//        setupConstraints()
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Theme.current.backgroundSecondary
        self.translatesAutoresizingMaskIntoConstraints = false

        setupViews()
        setupConstraints()
    }
    
    lazy var headerImage: UIImageView = {
        var headerImage = UIImageView()
        return headerImage
    }()
    
    lazy var gradientView: CAGradientLayer = {
        var gradientView = CAGradientLayer()
        gradientView.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientView.frame = CGRect(x: 0, y: 0, width: headerWidth, height: headerHeight)
        return gradientView
    }()
    
    lazy var titleText: UILabel = {
        var titleText = UILabel()
        titleText.text = "Title text here"
        titleText.numberOfLines = 1
        titleText.font = UIFont(name: Theme.current.boldFontName, size: Theme.current.textSizeBody1)
        titleText.textColor = UIColor.white
        return titleText
    }()
    
    lazy var contentView: UIView = {
        var contentView = UIView()
        return contentView
    }()
    
    lazy var readLengthText: UILabel = {
        var readLengthText = UILabel()
        readLengthText.text = "2 min read"
        readLengthText.font = UIFont(name: Theme.current.mainFontName, size: Theme.current.textSizeBody2)
        readLengthText.textColor = UIColor.white
        return readLengthText
    }()
    
    lazy var dateText: UILabel = {
        var dateText = UILabel()
        dateText.text = " ● 8 hourse ago"
        dateText.font = UIFont(name: Theme.current.mainFontName, size: Theme.current.textSizeBody2)
        dateText.textColor = UIColor.white
        return dateText
    }()
    
    lazy var bookmarkButton: UIButton = {
        var bookmarkButton = UIButton(type: .custom)
        bookmarkButton.tintColor = Theme.current.background
        bookmarkButton.isUserInteractionEnabled = true
        bookmarkButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        bookmarkButton.addTarget(self, action: #selector(handleBookmarkAction), for: .touchUpInside)
        return bookmarkButton
    }()
    
    @objc private func handleBookmarkAction() {
        if(bookmarkButton.image(for: .normal) == UIImage(named: "bookmark_outline_white")){
            self.delegate?.addTopArticleToBookmarks()
            bookmarkButton.setImage(UIImage(named: "bookmark_filled_white"), for: .normal)
        } else {
            self.delegate?.removeTopArticleFromBookmarks()
            bookmarkButton.setImage(UIImage(named: "bookmark_outline_white"), for: .normal)
        }
    }
    
    func setupViews() {
        self.addSubview(headerImage)
        self.layer.insertSublayer(gradientView, at: 100)
        self.addSubview(contentView)
        
        contentView.addSubview(readLengthText)
        contentView.addSubview(dateText)
        contentView.addSubview(titleText)
        contentView.addSubview(bookmarkButton)
    }
    
    func setupConstraints() {
        
        headerImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, centerX: nil, centerY: nil, size: CGSize(width: headerWidth, height: headerHeight))
        
        contentView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: headerImage.bottomAnchor, trailing: self.trailingAnchor, centerX: nil, centerY: nil, padding: UIEdgeInsets(top: Dimensions.margin, left: Dimensions.margin, bottom: Dimensions.margin, right: Dimensions.margin), size: CGSize(width: headerWidth, height: headerHeight))
        
        readLengthText.anchor(top: nil, leading: contentView.leadingAnchor, bottom: contentView.bottomAnchor, trailing: nil, centerX: nil, centerY: nil)
        
        dateText.anchor(top: nil, leading: readLengthText.trailingAnchor, bottom: contentView.bottomAnchor, trailing: nil, centerX: nil, centerY: nil)
        
        bookmarkButton.anchor(top: nil, leading: nil, bottom: contentView.bottomAnchor, trailing: contentView.trailingAnchor, centerX: nil, centerY: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), size: CGSize(width: 25, height: 25))
        
        titleText.anchor(top: nil, leading: contentView.leadingAnchor, bottom: bookmarkButton.topAnchor, trailing: contentView.trailingAnchor, centerX: nil, centerY: nil, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol BookmarkChangedProtocol {
    func addTopArticleToBookmarks()
    func removeTopArticleFromBookmarks()
}
