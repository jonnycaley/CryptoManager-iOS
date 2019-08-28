//
//  HeaderView.swift
//  CryptoManager
//
//  Created by Jonny Caley on 28/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit
import QuartzCore

class MainView: UIView {
    
    let headerHeight = 200
    let headerWidth = Int(UIScreen.main.bounds.size.width)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Theme.current.backgroundSecondary
        setupViews()
        setupConstraints()
    }
    
    lazy var headerImage: UIImageView = {
        var headerImage = UIImageView()
        return headerImage
    }()
    
    lazy var gradientView: CAGradientLayer = {
        var gradientView = CAGradientLayer()
        gradientView.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientView.frame = CGRect(x: 0, y: 0, width: headerWidth, height: headerHeight)
        return gradientView
    }()
    
    lazy var titleText: UILabel = {
        var titleText = UILabel()
        
        return titleText
    }()
    
    lazy var readLengthText: UILabel = {
        var readLengthText = UILabel()
        readLengthText.text = "Read Length"
        readLengthText.textColor = UIColor.white
        return readLengthText
    }()
    
    lazy var dateText: UILabel = {
        var dateText = UILabel()
        dateText.text = "Read Length"
        dateText.textColor = UIColor.white
        return dateText
    }()
    
    func setupViews() {
        self.addSubview(headerImage)
        self.layer.insertSublayer(gradientView, at: 100)
        self.addSubview(titleText)
        self.addSubview(readLengthText)
        self.addSubview(dateText)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        headerImage.translatesAutoresizingMaskIntoConstraints = false
        headerImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor, centerX: nil, centerY: nil, size: CGSize(width: headerWidth, height: headerHeight))
        
        readLengthText.translatesAutoresizingMaskIntoConstraints = false
        readLengthText.anchor(top: nil, leading: self.leadingAnchor, bottom: headerImage.bottomAnchor, trailing: self.trailingAnchor, centerX: nil, centerY: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
