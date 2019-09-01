//
//  WebView.swift
//  CryptoManager
//
//  Created by Jonny Caley on 30/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebView: WKWebView {
    
    var urlString: String
    
    required init(url: String) {
        self.urlString = url
        super.init(frame: .zero, configuration: WKWebViewConfiguration())
        
        print(self.urlString)
        guard let urll = URL(string: urlString) else { return }
        
        let urlRequest = URLRequest(url: urll)
        
        self.load(urlRequest)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
