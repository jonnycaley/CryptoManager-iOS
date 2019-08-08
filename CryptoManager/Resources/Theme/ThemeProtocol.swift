//
//  ThemeProtocol.swift
//  CryptoManager
//
//  Created by Jonny Caley on 08/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

protocol ThemeProtocol {
    var mainFontName: String { get }
    var textSizeBody2: CGFloat { get }
    var accent: UIColor { get }
    var background: UIColor { get }
    var text: UIColor { get }
}
