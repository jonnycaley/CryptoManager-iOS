//
//  SelectBaseCurrencyViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 19/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class SelectBaseCurrencyViewController: UIViewController, BackClickProtocol {
    func onBackPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    var buttonClickDelegate: BackClickProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.current.background
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.isNavigationBarHidden = true
        
        placeNavigationBar()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
    
    
    func placeNavigationBar(){
        
        let navigationBar = Bar()
        navigationBar.buttonClickDelegate = self
        
        view.addSubview(navigationBar)
        
        navigationBar.configureConstraints(view: view)
    }
}

extension SelectBaseCurrencyViewController:UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension UIImageView {
    func setImageColor(color: UIColor) {
        let templateImage = image?.withRenderingMode(.alwaysTemplate)
        image = templateImage
        tintColor = color
    }
}
