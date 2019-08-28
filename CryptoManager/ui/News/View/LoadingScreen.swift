//
//  LoadingScreen.swift
//  CryptoManager
//
//  Created by Jonny Caley on 28/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit

class LoadingOverlay: UIActivityIndicatorView {
        
    override init(style: UIActivityIndicatorView.Style) {
        super.init(style: style)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.startAnimating()
        self.backgroundColor = Theme.current.backgroundSecondary
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
