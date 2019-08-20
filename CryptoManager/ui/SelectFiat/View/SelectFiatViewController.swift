//
//  SelectBaseCurrencyViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 19/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FiatCell"

class SelectFiatViewController: UIViewController, BackClickProtocol, SelectFiatViewDelegate {
    
    private let selectFiatPresenter = SelectFiatPresenter(selectFiatService: SelectFiatService())
    
    var buttonClickDelegate: BackClickProtocol?
    
    let navigationBar = Bar()
    let tableView = UITableView()
    
    var fiats: [Fiat]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Theme.current.background

        hideNavigationBar()
        placeNavigationBar()
        addStatusHeader() //has to happen after configureTableView
        Utils.configureStatusBarColor()
        placeUITableView()
        
        selectFiatPresenter.setViewDelegate(selectFiatViewDelegate: self)
        selectFiatPresenter.onInit()
    }
    
    func addStatusHeader() {
        view.addSubview(StatusBarCover())
    }
    
    func hideNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.isNavigationBarHidden = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }

    func placeNavigationBar() {
        navigationBar.buttonClickDelegate = self
        view.addSubview(navigationBar)
        navigationBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor)
    }
    
    func onBackPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func loadFiats(fiats: [Fiat]) {
        self.fiats = fiats.sorted(by: { (fiat1, fiat2) -> Bool in
            fiat1.fiat < fiat2.fiat
        })
        self.tableView.reloadData()
    }
    
    func placeUITableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = self.view.frame
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        tableView.tableFooterView = UIView()
        tableView.anchor(top: navigationBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        
        tableView.register(FiatCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
}

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
}

extension SelectFiatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fiats = self.fiats {
            return fiats.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? FiatCell else {fatalError("unable to create cell")}
        cell.fiatName.text = Utils.getFiatName(fiat: fiats?[indexPath.row].fiat)
        cell.fiatAbbreviaition.text = fiats?[indexPath.row].fiat
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
}

extension SelectFiatViewController: UINavigationBarDelegate {
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
