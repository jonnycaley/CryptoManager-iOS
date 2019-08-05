//
//  SettingsViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 04/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit
import Foundation

class SettingsViewController: UITableViewController, SettingsViewDelegate {
    
    private let settingsPresenter = SettingsPresenter(settingsService: SettingsService())
    
    let settingsGeneral = ["Select Base Currency",
                           "Night Mode"]
    
    let settingsData = ["Bookmarked Articles",
                        "Full Transaction History",
                        "Delete All Articles",
                        "Delete Portfolio"]
    
    let settingsAbout = ["Review This App",
                         "Share This App",
                         "Send Feedback",
                         "Currency Predictor",
                         "Version 1.0.0.3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsPresenter.setViewDelegate(settingsViewDelegate: self)
        
        settingsPresenter.getSettings()
        
        let window = UIWindow()
        window.makeKeyAndVisible()
        window.rootViewController = SettingsViewController()
        
        // Do any additional setup after loading the view.
    }
    
    func displaySettings(settings: (Array<String>)) {
        print(settings)
    }
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return settingsGeneral.count
//        } else if section == 1{
//            return settingsData.count
//        } else {
//            return settingsAbout.count
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = UITableViewCell()
//
//        if indexPath.section == 0 {
//            cell.textLabel?.text = settingsGeneral[indexPath.row]
//        } else if indexPath.section == 1 {
//            cell.textLabel?.text = settingsData[indexPath.row]
//        } else {
//            cell.textLabel?.text = settingsAbout[indexPath.row]
//        }
//
//        return cell
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 3
//    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
