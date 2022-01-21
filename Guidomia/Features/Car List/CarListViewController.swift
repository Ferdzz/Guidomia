//
//  CarListViewController.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-20.
//

import UIKit

class CarListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup view
        self.title = NSLocalizedString("App.Name", comment: "")
        self.navigationController?.navigationBar.barTintColor = Colors.orange
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        
        // Setup tableView
        self.tableView.register(cell: CarListHeaderTableViewCell.self)
        self.tableView.register(cell: CarTableViewCell.self)
        self.tableView.rowHeight = UITableView.automaticDimension
    }
}

extension CarListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let headerCell = self.tableView.dequeue(cell: CarListHeaderTableViewCell.self, for: indexPath)
//        headerCell.configure(item: .init(backgroundImage: UIImage(named: "Tacoma")!, title: "Tacoma 2021", subtitle: "Get yours now"))
//        return headerCell
        let cell = tableView.dequeue(cell: CarTableViewCell.self, for: indexPath)
        cell.configure(item: .init(carImage: UIImage(named: "Tacoma")!, carName: "Alpine Roadster", carPrice: "Price : 120k", carRating: 4))
        return cell
    }
}
