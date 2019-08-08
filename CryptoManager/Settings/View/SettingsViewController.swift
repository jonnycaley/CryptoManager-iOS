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
    
    var themeChangeDelegate: ThemeChangeProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        
        settingsPresenter.setViewDelegate(settingsViewDelegate: self)
        settingsPresenter.getSettings()
    }
    
    func configureUI() {
        configureTableView()
    }
    
    func configureTableView() {
        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        
        tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
    fileprivate func applyTheme() {
        tableView.reloadData()
        
    }
    
    func displaySettings(settings: (Array<String>)) {
        print(settings)
    }
    
    func onThemeChanged() {
        
        applyTheme()
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
        view.backgroundColor = UIColor.lightGray
        
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textColor = .black
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
            print(GeneralOptions(rawValue: indexPath.row)?.description)
        case .Data:
            print(DataOptions(rawValue: indexPath.row)?.description)
        case .About:
            print(AboutOptions(rawValue: indexPath.row)?.description)
        }
    }
}
