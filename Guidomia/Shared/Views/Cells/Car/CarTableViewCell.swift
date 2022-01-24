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

    struct Item {
        let carImage: String
        let carName: String
        let carPrice: String
        let carRating: Double
        let prosList: [String]
        let consList: [String]
        /// Defines if the item should show the pros&cons list
        var isExpanded: Bool
    }
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var carPriceLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    /// A view containing both pros and cons contents
    @IBOutlet weak var prosAndConsView: UIView!
    @IBOutlet weak var prosStackView: UIStackView!
    @IBOutlet weak var prosLabel: UILabel!
    @IBOutlet weak var consStackView: UIStackView!
    @IBOutlet weak var consLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.prosLabel.text = NSLocalizedString("CarList.Pros", comment: "")
        self.consLabel.text = NSLocalizedString("CarList.Cons", comment: "")
    }
    
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
        
        self.prosAndConsView.isHidden = !item.isExpanded
        // Only process the pros&cons list if the item is expanded
        if item.isExpanded {
            // Remove all subviews of type BulletPointView of the pros&cons stackviews
            self.prosStackView.removeArrangedSubviews(where: { $0 is BulletPointView })
            self.consStackView.removeArrangedSubviews(where: { $0 is BulletPointView })
            // If a list has no items, then we hide the entire section. Since we're using TableViews, the views will
            // re-organize correctly to hide the entire section
            self.prosStackView.isHidden = item.prosList.isEmpty
            self.consStackView.isHidden = item.consList.isEmpty
            // Create BulletPointViews for each entry in the pros&cons lists, and add them to the stackview
            self.prosStackView.addArrangedSubviews(views: item.prosList.map({
                let bulletPointView = BulletPointView(frame: .zero)
                bulletPointView.configure(text: $0)
                return bulletPointView
            }))
            self.consStackView.addArrangedSubviews(views: item.consList.map({
                let bulletPointView = BulletPointView(frame: .zero)
                bulletPointView.configure(text: $0)
                return bulletPointView
            }))
            
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
}
