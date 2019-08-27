//
//  DarkTheme.swift
//  CryptoManager
//
//  Created by Jonny Caley on 08/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class DarkTheme: ThemeProtocol {
    var mainFontName: String = "Roboto-Regular"
    
    var textSizeBody2: CGFloat = 14 as CGFloat
    
    var theme: UIColor = UIColor(named: "Theme")!
    var background: UIColor = UIColor(named: "BackgroundDarkTheme")!
    var text: UIColor = UIColor(named: "TextDarkTheme")!
    var backgroundSecondary: UIColor = UIColor(named: "BackgroundSecondaryDarkTheme")!
    
    var icons: UIColor = UIColor(named: "IconDarkTheme")!
}
