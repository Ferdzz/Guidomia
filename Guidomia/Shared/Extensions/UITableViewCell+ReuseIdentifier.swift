//
//  UITableViewCell+ReuseIdentifier.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-20.
//

import Foundation
import UIKit

extension UIView {
    
    /// Returns the name of the nib associated to this UIView type
    static func nibName() -> String {
        return String(describing: self)
    }
}
