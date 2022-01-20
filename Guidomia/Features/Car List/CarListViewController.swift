//
//  CarListViewController.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-20.
//

import UIKit

class CarListViewController: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.barTintColor = Colors.orange
        navigationController?.navigationBar.barStyle = .black
    }
}
