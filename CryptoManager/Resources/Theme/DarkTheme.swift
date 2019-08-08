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
    var accent: UIColor = UIColor(named: "Accent")!
    var background: UIColor = UIColor(named: "BackgroundDarkTheme")!
    var text: UIColor = UIColor(named: "TextDarkTheme")!
}
