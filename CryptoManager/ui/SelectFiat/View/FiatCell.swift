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
    
    lazy var fiatCircle: CAShapeLayer = {
        let fiatCircle = CAShapeLayer()
        fiatCircle.path = UIBezierPath(ovalIn: CGRect(x: 50, y: 50, width: 100, height: 100)).cgPath
        return fiatCircle
    }()
    
    lazy var fiatAbbreviaition: UILabel = {
        let fiatAbbreviaition = UILabel(frame: CGRect(x: 20, y: 20, width: 100, height: 20))
        
        fiatAbbreviaition.textAlignment = .left
        
        return fiatAbbreviaition
    }()
    
    lazy var fiatName: UILabel = {
        let fiatName = UILabel(frame: CGRect(x: 120, y: 20, width: 200, height: 20))
        fiatName.textAlignment = .left
        
        return fiatName
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(fiatName)
        addSubview(fiatAbbreviaition)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
