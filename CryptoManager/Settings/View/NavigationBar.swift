//
//  NavigationBar.swift
//  CryptoManager
//
//  Created by Jonny Caley on 09/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class NavigationBar: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        self.backgroundColor = Theme.current.background
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
