//
//  UITableViewCell+ReuseIdentifier.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-20.
//

import Foundation
import UIKit

extension UITableViewCell {
    
    static func reuseIdentifier() -> String {
        return String(describing: self)
    }
}
