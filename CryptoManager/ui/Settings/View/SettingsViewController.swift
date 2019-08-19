//
//  SettingsViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 04/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit
import Foundation

private let reuseIdentifier = "SettingsCell"

class SettingsViewController: UIViewController, SettingsViewDelegate, ThemeChangeProtocol {
    
    private let settingsPresenter = SettingsPresenter(settingsService: SettingsService())
    
    var tableView: UITableView!
    var customView: UIView!

    var themeChangeDelegate: ThemeChangeProtocol?
    var newViewDelegate: NewViewControllerProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        settingsPresenter.setViewDelegate(settingsViewDelegate: self)
        settingsPresenter.getSettings()
    }
    
    
    func configureUI() {
        
        configureTableView()
        addStatusHeader() //has to happen after configureTableView
        configureStatusBarColor()
        view.addSubview(NavigationBar())
    }
    
    func configureStatusBarColor() {
        if(UserDefaults.standard.bool(forKey: "isDarkTheme")) {
            UIApplication.shared.statusBarStyle = .lightContent
        } else {
            UIApplication.shared.statusBarStyle = .default
        }
    }
    
    func addStatusHeader() {
        view.addSubview(NavigationBar())
    }
    
    func configureTableView() {
        
        if(tableView == nil){
            
            tableView = UITableView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 60
            
            // the following line configure table view for top space
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
            view.addSubview(tableView)
            tableView.frame = view.frame
        } else {
            
            tableView.reloadData()
        }
        tableView.backgroundColor = Theme.current.background
    }
    
    func displaySettings(settings: (Array<String>)) {
        print(settings)
    }
    
    func onThemeChanged() {
        
        configureUI()
        self.themeChangeDelegate?.onThemeChanged()
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let section = SettingsSection(rawValue: section) else { return 0}
        
        switch section {
        case .General: return GeneralOptions.allCases.count
        case .Data: return DataOptions.allCases.count
        case .About: return AboutOptions.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Theme.current.backgroundSecondary
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = Theme.current.text
        title.text = SettingsSection(rawValue: section)?.description    
        view.addSubview(title)
        title.translatesAutoresizingMaskIntoConstraints = false
        title.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SettingsCell
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        cell.delegate = self //to allow for the SettingsCellProtocol methods to be called from the SettingsCell class (for theme changing)
        
        guard let section = SettingsSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .General:
            let general = GeneralOptions(rawValue: indexPath.row)
            cell.sectionType = general
        case .Data:
            let data = DataOptions(rawValue: indexPath.row)
            cell.sectionType = data
        case .About:
            let about = AboutOptions(rawValue: indexPath.row)
            cell.sectionType = about
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = SettingsSection(rawValue: indexPath.section) else { return }
        
        switch section {
        case .General:
            switch GeneralOptions(rawValue: indexPath.row) {
            case GeneralOptions(rawValue: 0)?:
                print("Onclick")
                toActivity(destinationController: SelectBaseCurrencyViewController())
            case GeneralOptions(rawValue: 1)?:
                break
            case .none:
                break
            case .some(_):
                break
            }
            
        case .Data:
            print(DataOptions(rawValue: indexPath.row)?.description)
        case .About:
            print(AboutOptions(rawValue: indexPath.row)?.description)
        }
    }
    
    func toActivity(destinationController : UIViewController) {
        self.newViewDelegate?.onNewView(destinationController: destinationController)
//        self.navigationController?.pushViewController(destinationController, animated: true)
//        self.present(destinationController, animated: true, completion: nil)
    }
}
