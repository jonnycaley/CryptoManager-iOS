//
//  NewsService.swift
//  CryptoManager
//
//  Created by Jonny Caley on 28/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import RxSwift

class NewsService {
    func getNews() -> Single<News> {
        return CryptoControlService.shared.getTopNews()
    }
}
