//
//  CarListViewController.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-20.
//

import UIKit

protocol CarListViewControllerProtocol: AnyObject {
    func showData(sections: [Section<CarListRow>])
    func showLoading()
    func hideLoading()
    func showError(error: Error)
}

class CarListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    
    /// Contains the list of all rows, divided in sections
    private var sections: [Section<CarListRow>] = []
    /// The currently expanded index path
    private var expandedIndexPath: IndexPath?
    
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
        self.tableView.register(cell: SeparatorTableViewCell.self)
        self.tableView.register(cell: FilterTableViewCell.self)
        self.tableView.rowHeight = UITableView.automaticDimension
        // Disable the extra empty rows
        self.tableView.tableFooterView = UIView()
        
        // Register to keyboard events so that we may properly handle tableview offsets
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow(notification:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        
        self.interactor.onViewDidLoad()
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        // Add an inset to the tableview when the keyboard is shown so that nothing is hidden behind
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        // Remove the inset when the keyboard is hidden
        tableView.contentInset = .zero
    }
}

extension CarListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.sections[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get the row configuration for this IndexPath
        let row = self.sections[indexPath.section].rows[indexPath.row]
        
        // Configure the cell with the provided item
        switch row {
        case let .header(item):
            let cell = tableView.dequeue(cell: CarListHeaderTableViewCell.self, for: indexPath)
            cell.configure(item: item)
            return cell
        case let .filter(item):
            let cell = tableView.dequeue(cell: FilterTableViewCell.self, for: indexPath)
            cell.configure(item: item, delegate: self)
            return cell
        case let .car(item):
            let cell = tableView.dequeue(cell: CarTableViewCell.self, for: indexPath)
            cell.configure(item: item)
            return cell
        case .separator:
            return tableView.dequeue(cell: SeparatorTableViewCell.self, for: indexPath)
        }
    }
}

extension CarListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Get the row configuration for this indexpath
        let row = self.sections[indexPath.section].rows[indexPath.row]
        
        switch row {
        case var .car(item):
            // If we tapped a car item, then toggle the isExpanded property
            item.isExpanded.toggle()
            self.sections[indexPath.section].rows[indexPath.row] = .car(item: item)
            // We need to collapse the previously expanded item
            if let expandedIndexPath = self.expandedIndexPath, expandedIndexPath != indexPath {
                let previousExpandedRow = self.sections[expandedIndexPath.section].rows[expandedIndexPath.row]
                switch previousExpandedRow {
                case var .car(item):
                    item.isExpanded = false
                    self.sections[expandedIndexPath.section].rows[expandedIndexPath.row] = .car(item: item)
                default: break
                }
            }
            // Reload the updated rows
            tableView.reloadRows(at: [indexPath, expandedIndexPath].compactMap({ $0 }), with: .automatic)
            self.expandedIndexPath = item.isExpanded ? indexPath : nil
        default: break
        }
    }
}

extension CarListViewController: FilterTableViewCellDelegate {
    func didSelectMake(value: String?) {
        interactor.didSelectMake(value: value)
    }
    
    func didSelectModel(value: String?) {
        interactor.didSelectModel(value: value)
    }
}

extension CarListViewController: CarListViewControllerProtocol {
    func showData(sections: [Section<CarListRow>]) {
        // Reload the TableView data on the UI thread
        DispatchQueue.main.async {
            self.sections = sections
            // TODO: Future improvement: This IndexPath could be provided by the interactor
            self.expandedIndexPath = IndexPath(row: 0, section: 2)
            self.tableView.reloadData()
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
            self.loadingIndicator.startAnimating()
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = true
            self.loadingIndicator.stopAnimating()
        }
    }
    
    func showError(error: Error) {
        DispatchQueue.main.async {
            self.errorView.isHidden = false
            self.errorLabel.text = error.localizedDescription            
        }
    }
}
