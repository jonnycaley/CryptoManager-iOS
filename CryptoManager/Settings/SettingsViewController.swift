//
//  SettingsViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 04/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UIViewController, SettingsViewDelegate {
    
    private let settingsPresenter = SettingsPresenter(settingsService: SettingsService())

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsPresenter.setViewDelegate(settingsViewDelegate: self)
        
        settingsPresenter.getSettings()
        // Do any additional setup after loading the view.
    }
    
    func displaySettings(settings: (Array<String>)) {
        print(settings)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
