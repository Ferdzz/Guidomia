//
//  CarListViewController.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-20.
//

import UIKit

protocol CarListViewControllerProtocol: AnyObject {
    func showData(sections: [Section<CarListRow>])
}

class CarListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    /// Contains the list of all rows, divided in sections
    private var sections: [Section<CarListRow>] = []
    
    private lazy var interactor: CarListInteractorProtocol = {
        CarListInteractor(viewController: self)
    }()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        // Override the status bar style so that the status bar displays in white
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
        // Disable the extra empty rows
        self.tableView.tableFooterView = UIView()
        
        self.interactor.onViewDidLoad()
    }
}

extension CarListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the row configuration for this indexpath
        let row = sections[indexPath.section].rows[indexPath.row]
        
        switch row {
        case let .header(item: item):
            let cell = self.tableView.dequeue(cell: CarListHeaderTableViewCell.self, for: indexPath)
            cell.configure(item: item)
            return cell
        case let .car(item):
            let cell = tableView.dequeue(cell: CarTableViewCell.self, for: indexPath)
            cell.configure(item: item)
            return cell
        }
    }
}

extension CarListViewController: CarListViewControllerProtocol {
    
    func showData(sections: [Section<CarListRow>]) {
        // Reload the TableView data on the UI thread
        DispatchQueue.main.async {
            self.sections = sections
            self.tableView.reloadData()
        }
    }
}
