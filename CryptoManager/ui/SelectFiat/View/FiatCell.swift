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
        return fiatAbbreviaition
    }()
    
    lazy var fiatName: UILabel = {
        let fiatName = UILabel(frame: CGRect(x: 60, y: 20, width: 200, height: 20))
        fiatName.textAlignment = .left
        fiatName.font = UIFont.systemFont(ofSize: Theme.current.textSizeBody2)
        fiatName.textColor = Theme.current.text
        return fiatName
    }()
    
    lazy var fiatTick: UIImageView = {
        let fiatTickImage = UIImage(named: "tick")
        
        let tintedImage = fiatTickImage?.withRenderingMode(.alwaysTemplate)
        var fiatImageView = UIImageView(image: tintedImage)
        fiatImageView.tintColor = Theme.current.text
//        fiatImageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        return fiatImageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = Theme.current.background
        
        self.addSubview(fiatCircle)
        fiatCircle.translatesAutoresizingMaskIntoConstraints = false
        fiatCircle.anchor(top: nil, leading: self.leadingAnchor, bottom: nil, trailing: nil, centerX: nil, centerY: contentView.centerYAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14), size: CGSize(width: 45, height: 45))
        
        self.addSubview(fiatTick)
        fiatTick.translatesAutoresizingMaskIntoConstraints = false
        fiatTick.anchor(top: nil, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, centerX: nil, centerY: contentView.centerYAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14), size: CGSize(width: 45, height: 45))
        
        self.addSubview(fiatName)
        fiatName.translatesAutoresizingMaskIntoConstraints = false
        fiatName.anchor(top: nil, leading: fiatCircle.trailingAnchor, bottom: nil, trailing: fiatTick.leadingAnchor, centerX: nil, centerY: contentView.centerYAnchor, padding: UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
