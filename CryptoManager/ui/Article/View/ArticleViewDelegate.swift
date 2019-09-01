//
//  ArticleViewDelegate.swift
//  CryptoManager
//
//  Created by Jonny Caley on 30/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation

protocol ArticleViewDelegate: NSObjectProtocol {
    func getArticleId() -> String
    func showOutlinedBookmarkIcon()
    func showFilledBookmarkIcon()
}
