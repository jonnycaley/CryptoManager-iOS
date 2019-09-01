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
    
    var baseFiat: SQLFiat?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsPresenter.setViewDelegate(settingsViewDelegate: self)
        settingsPresenter.getSettings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(baseFiat != nil) {
            settingsPresenter.getSettings()
        }
    }
    
    func configureUI() {
        configureTableView()
        addStatusHeader() //has to happen after configureTableView
    }
    
    func addStatusHeader() {
        view.addSubview(StatusBarCover())
    }
    
    func configureTableView() {
        if(tableView == nil){
            tableView = UITableView()
            print(tableView == nil)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 60
            tableView.tableFooterView = UIView()
            
            // the following line configure table view for top space
            tableView.translatesAutoresizingMaskIntoConstraints = false
            
            tableView.register(SettingsCell.self, forCellReuseIdentifier: reuseIdentifier)
            view.addSubview(tableView)
            
            tableView.frame = view.frame
        } else {
            UIView.setAnimationsEnabled(false)
            tableView.beginUpdates()
            tableView.reloadData()
            //tableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)      taken out cause didn't update with theme change
            tableView.endUpdates()
            UIView.setAnimationsEnabled(true)
        }
        tableView.backgroundColor = Theme.current.background
    }
    
    func displaySettings(settings: Array<String>, baseFiat: SQLFiat) {
        self.baseFiat = baseFiat
        configureUI()
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
            if(general?.description == GeneralOptions.SelectBaseCurrency.description) {
                cell.textLabel?.text = "\(cell.textLabel!.text!) \(baseFiat!.name) \(String(format: "%.2f", baseFiat!.rate))"
            }
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
                var controller = SelectFiatViewController()
                self.navigationController?.pushViewController(controller, animated: true)
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
    
}
