//
//  CarTableViewCell.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import UIKit
import Cosmos

class CarTableViewCell: UITableViewCell {

    // TODO: Items should be ViewModels and responsible for transforming API data into FE data
    struct Item {
        let carImage: UIImage
        let carName: String
        let carPrice: String
        let carRating: Double
    }
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    func configure(item: Item) {
        self.carImageView.image = item.carImage
        self.carNameLabel.text = item.carName
        self.carPriceLabel.text = item.carPrice
        self.ratingView.rating = item.carRating
    }
}
