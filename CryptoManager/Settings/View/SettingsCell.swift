//
//  SettingsCell.swift
//  CryptoManager
//
//  Created by Jonny Caley on 06/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    // MARK: - Properties
    
    var delegate: ThemeChangeProtocol?
    
    var sectionType: SectionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            textLabel?.text = sectionType.description
            
            textLabel?.font = UIFont(name: Theme.current.mainFontName, size: Theme.current.textSizeBody2)
            textLabel?.textColor = Theme.current.text
            
            backgroundColor = Theme.current.background
            
            switchControl.isHidden = !sectionType.containsSwitch
        }
    }
    
    lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
                
        switchControl.isOn = UserDefaults.standard.bool(forKey: "isDarkTheme")
        switchControl.onTintColor = UIColor(red: 55/255, green: 120/255, blue: 250/255, alpha: 1)
        switchControl.translatesAutoresizingMaskIntoConstraints = false
        switchControl.addTarget(self, action: #selector(handleSwitchAction), for: .valueChanged)
        return switchControl
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(switchControl)
        switchControl.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        switchControl.rightAnchor.constraint(equalTo: rightAnchor, constant: -12).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Selectors
    
    @objc func handleSwitchAction(sender: UISwitch) {
        Theme.current = sender.isOn ? DarkTheme() : LightTheme()
        
        UserDefaults.standard.set(sender.isOn, forKey: "isDarkTheme")
        
        self.delegate?.onThemeChanged()
    }
}

protocol ThemeChangeProtocol {
    func onThemeChanged()
}
