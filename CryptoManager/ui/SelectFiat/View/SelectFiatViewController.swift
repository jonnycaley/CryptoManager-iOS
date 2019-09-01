//
//  SelectBaseCurrencyViewController.swift
//  CryptoManager
//
//  Created by Jonny Caley on 19/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

private let reuseIdentifier = "FiatCell"

class SelectFiatViewController: UIViewController, ArticleViewOnClickProtocol, SelectFiatViewDelegate {
    
    private let selectFiatPresenter = SelectFiatPresenter(selectFiatService: SelectFiatService())
    
    var buttonClickDelegate: ArticleViewOnClickProtocol?
    
    let navigationBar = Bar()
    let tableView = UITableView()
    
    var fiats: [SQLFiat]?
    
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
        navigationBar.articleClickDelegate = self
        view.addSubview(navigationBar)
        navigationBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, centerX: nil, centerY: nil)
    }
    
    func onBackPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    func loadFiats(fiats: [SQLFiat]) {
        self.fiats = fiats.sorted(by: { (fiat1, fiat2) -> Bool in
            fiat1.name < fiat2.name
        })
        self.tableView.reloadData()
    }
    
    func placeUITableView() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.frame = self.view.frame
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = Theme.current.background
        view.addSubview(tableView)
        
        tableView.tableFooterView = UIView()
        tableView.anchor(top: navigationBar.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, centerX: nil, centerY: nil)
        
        tableView.register(FiatCell.self, forCellReuseIdentifier: reuseIdentifier)
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
        
        let fiat = fiats?[indexPath.row]
        
        cell.fiatName.text = fiat?.name.getFiatName()
        cell.fiatCircle.text = fiat?.name
        
        cell.fiatTick.isHidden = !(fiat?.isBaseFiat ?? true)
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectFiatPresenter.setBaseFiat(chosenFiat: fiats![indexPath.row])
        
        for index in 0...(getFiatsCount()-1) {
            let indexPathh = IndexPath(row: index, section: 0)
            let cell = tableView.cellForRow(at: indexPathh) as? FiatCell
            if(index == indexPath.row){
                cell?.fiatTick.isHidden = false
            } else {
                cell?.fiatTick.isHidden = true
            }
        }
    }
    
    func getFiatsCount() -> Int {
        if let fiats = self.fiats {
            return fiats.count
        }
        return 0
    }
    
    func addArticleToBookmarks() {
        //not needed
    }
    
    func removeArticleFromBookmarks() {
        //not needed
    }
}

extension SelectFiatViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
