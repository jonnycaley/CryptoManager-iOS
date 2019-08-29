//
//  NewsViewDelegate.swift
//  CryptoManager
//
//  Created by Jonny Caley on 28/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

protocol NewsViewDelegate: NSObjectProtocol {
    func loadTopArticle(news: Article, isSaved: Bool)
    func hideLoadingScreen()
}
