//
//  Splash.swift
//  CryptoManager
//
//  Created by Jonny Caley on 06/08/2019.
//  Copyright © 2019 jonnycaley. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        navigationItem.title = "Splash"
//        navigationController?.navigationBar.prefersLargeTitles = true
        
        let mainViewController = MainTabBarController()
        self.present(mainViewController, animated: true, completion: nil)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
