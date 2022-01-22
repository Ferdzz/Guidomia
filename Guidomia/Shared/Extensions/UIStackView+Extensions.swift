//
//  UIStackView+Extensions.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-22.
//

import Foundation
import UIKit

extension UIStackView {
    
    /// Removes all the arranged subviews where the filtering callback returns true
    func removeArrangedSubviews(where callback: (UIView) -> Bool) {
        for subview in self.arrangedSubviews {
            if callback(subview) {
                self.removeArrangedSubview(subview)
                subview.removeFromSuperview()
            }
        }
    }
    
    /// Adds all the views provided to the stackview
    func addArrangedSubviews(views: [UIView]) {
        for view in views {
            self.addArrangedSubview(view)
        }
    }
}
