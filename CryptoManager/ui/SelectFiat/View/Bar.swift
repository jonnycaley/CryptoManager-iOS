//
//  Bar.swift
//  CryptoManager
//
//  Created by Jonny Caley on 19/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit

class Bar: UINavigationBar {
    
    var buttonClickDelegate: BackClickProtocol?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isTranslucent = false
        self.barTintColor = Theme.current.background
        
        //enables autolayout
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage()
        
        let navButton = navItem
        createBackBarButton(navigationItem: navButton)
        
        self.items = [navButton]
    }
    
    func createBackBarButton(navigationItem:UINavigationItem){
        let backBarButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = backBarButton
    }
    
    lazy var backButton: UIButton = {
        let backButtonImage = UIImage(named: "arrow_back_black")
        let tintedImage = backButtonImage?.withRenderingMode(.alwaysTemplate)
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: backButtonImage!.size.width, height: backButtonImage!.size.height))
        backButton.addTarget(self, action: #selector(backBarButtonTapped), for: .touchUpInside)
        backButton.setImage(tintedImage!, for: .normal)
        backButton.tintColor = Theme.current.icons
        
        return backButton
    }()
    
    lazy var navItem : UINavigationItem = {
        let navItem = UINavigationItem()
        return navItem
    }()
    
    @objc func backBarButtonTapped() {
        print("Clicked")
        self.buttonClickDelegate?.onBackPressed()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol BackClickProtocol {
    func onBackPressed()
}
