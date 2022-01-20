//
//  CarListHeaderTableViewCell.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-20.
//

import UIKit

class CarListHeaderTableViewCell: UITableViewCell {

    struct Item {
        let backgroundImage: UIImage
        let title: String
        let subtitle: String
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    public func configure(item: Item) {
        self.backgroundImageView.image = item.backgroundImage
        self.titleLabel.text = item.title
        self.subtitleLabel.text = item.subtitle
    }
}
