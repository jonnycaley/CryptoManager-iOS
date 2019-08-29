//
//  LightTheme.swift
//  CryptoManager
//
//  Created by Jonny Caley on 08/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class LightTheme: ThemeProtocol {    
    var mainFontName: String = "Roboto-Regular"
    var boldFontName: String = "Roboto-Bold"

    var textSizeBody1: CGFloat = 18 as CGFloat
    var textSizeBody2: CGFloat = 14 as CGFloat

    var theme: UIColor = UIColor(named: "Theme")!
    var background: UIColor = UIColor(named: "BackgroundLightTheme")!
    var text: UIColor = UIColor(named: "TextLightTheme")!
    var backgroundSecondary: UIColor = UIColor(named: "BackgroundSecondaryLightTheme")!
    
    var icons: UIColor = UIColor(named: "IconLightTheme")!
}
