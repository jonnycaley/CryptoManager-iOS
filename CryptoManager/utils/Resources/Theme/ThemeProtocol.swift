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
    
//  text sizes
    var textSizeBody2: CGFloat { get }
    
//  colors
    var accent: UIColor { get }
    var background: UIColor { get }
    var text: UIColor { get }
    var backgroundSecondary: UIColor { get }
    var icons: UIColor { get }
}
