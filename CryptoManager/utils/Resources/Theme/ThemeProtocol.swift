//
//  ThemeProtocol.swift
//  CryptoManager
//
//  Created by Jonny Caley on 08/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
//  fonts
    var mainFontName: String { get }
    var boldFontName: String { get }

//  text sizes
    var textSizeBody1: CGFloat { get }
    var textSizeBody2: CGFloat { get }

//  colors
    var theme: UIColor { get }
    var background: UIColor { get }
    var text: UIColor { get }
    var backgroundSecondary: UIColor { get }
    var icons: UIColor { get }
}
