//
//  CarTableViewCell.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-21.
//

import UIKit
import Cosmos
import Kingfisher

class CarTableViewCell: UITableViewCell {

    // TODO: Items should be ViewModels and responsible for transforming API data into FE data
    struct Item {
        let carImage: String
        let carName: String
        let carPrice: String
        let carRating: Double
    }
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    
    func configure(item: Item) {
        // Load the image from path using Kingfisher asynchronously
        if let path = Bundle.main.path(forResource: item.carImage, ofType: nil) {
            let url = URL(fileURLWithPath: path)
            let provider = LocalFileImageDataProvider(fileURL: url)
            self.carImageView.kf.indicatorType = .activity
            self.carImageView.kf.setImage(with: provider, options: nil)
        } else {
            // If I had a placeholder/error image, this is where it would go
            self.carImageView.image = UIImage()
        }
        self.carNameLabel.text = item.carName
        self.carPriceLabel.text = item.carPrice
        self.ratingView.rating = item.carRating
    }
}
