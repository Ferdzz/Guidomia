//
//  UITableView+Extensions.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-20.
//

import Foundation
import UIKit

extension UITableView {
    
    func register(cell: UITableViewCell.Type) {
        self.register(UINib(nibName: cell.reuseIdentifier(), bundle: nil), forCellReuseIdentifier: cell.reuseIdentifier())
    }
    
    func dequeue<T: UITableViewCell>(cell: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = self.dequeueReusableCell(withIdentifier: T.reuseIdentifier(), for: indexPath) as? T else {
            preconditionFailure("Attempted to dequeue a cell of an unregistered type")
        }
        return cell
    }
}
