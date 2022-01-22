//
//  UITableView+Extensions.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-20.
//

import Foundation
import UIKit

extension UITableView {
    
    /// Registers a TableViewCell using the default nib name
    func register(cell: UITableViewCell.Type) {
        self.register(UINib(nibName: cell.nibName(), bundle: nil), forCellReuseIdentifier: cell.nibName())
    }
    
    /// Dequeues a TableViewCell using the default nib name. Make sure to use `register(cell: UITableViewCell.Type)`
    /// to register this cell type.
    /// - Returns: A type-checked instance of the requested TableViewCell, dequeued for the indexPath provided
    func dequeue<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.nibName(), for: indexPath) as? T else {
            preconditionFailure("Attempted to dequeue a cell of an unregistered type")
        }
        return cell
    }
}
