//
//  FiatCell.swift
//  CryptoManager
//
//  Created by Jonny Caley on 20/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import Foundation
import UIKit

class FiatCell: UITableViewCell {
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    lazy var fiatCircle: UILabel = {
        
        let size:CGFloat = 45.0
        
        let fiatCircle = UILabel(frame: CGRect(x : 0.0,y : 0.0,width : size, height :  size))
        fiatCircle.text = "TES"
        fiatCircle.textColor = Theme.current.text
        fiatCircle.textAlignment = .center
        
        fiatCircle.font = UIFont.systemFont(ofSize: 12.0)
        fiatCircle.layer.cornerRadius = size / 2
        fiatCircle.layer.masksToBounds = true
        fiatCircle.layer.backgroundColor = Theme.current.backgroundSecondary.cgColor
        
        fiatCircle.translatesAutoresizingMaskIntoConstraints = false
        return fiatCircle
    }()
    
    lazy var fiatAbbreviaition: UILabel = {
        let fiatAbbreviaition = UILabel(frame: CGRect(x: 20, y: 20, width: 40, height: 20))
        fiatAbbreviaition.textAlignment = .center
        fiatAbbreviaition.layer.borderColor = UIColor.blue.cgColor
        fiatAbbreviaition.layer.borderWidth = 1
        return fiatAbbreviaition
    }()
    
    
    lazy var fiatName: UILabel = {
        let fiatName = UILabel(frame: CGRect(x: 60, y: 20, width: 200, height: 20))
        fiatName.textAlignment = .left
        fiatName.layer.borderColor = UIColor.green.cgColor
        fiatName.layer.borderWidth = 1
        return fiatName
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(fiatCircle)
        fiatCircle.translatesAutoresizingMaskIntoConstraints = false
        fiatCircle.anchor(top: nil, leading: self.leadingAnchor, bottom: nil, trailing: nil, centerX: nil, centerY: contentView.centerYAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14), size: CGSize(width: 45, height: 45))
        
        self.addSubview(fiatName)
        fiatName.translatesAutoresizingMaskIntoConstraints = false
        fiatName.anchor(top: nil, leading: fiatCircle.trailingAnchor, bottom: nil, trailing: contentView.trailingAnchor, centerX: nil, centerY: contentView.centerYAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14))
        
//        fiatName.leadingAnchor.constraint(equalTo: fiatCircle.trailingAnchor)
//
//        fiatCircle.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        fiatCircle.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        fiatCircle.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        cellView.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
//
        
        
        
//        fiatCircle.centerXAnchor.constraint(equalTo: fiatName)
        
//        fiatCircle.topAnchor.constraint(equalTo: profileImage.topAnchor).isActive = true
//        fiatCircle.trailingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 10).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
