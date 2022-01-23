//
//  FilterTableViewCell.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-23.
//

import UIKit

class FilterTableViewCell: UITableViewCell {

    @IBOutlet weak var filterBackgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var makeButton: UIButton!
    @IBOutlet weak var modelButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.filterBackgroundView.layer.cornerRadius = Constants.cornerRadius
        
        // Setup the button styles with shadow and rounded corners
        self.makeButton.layer.cornerRadius = Constants.cornerRadius
        self.modelButton.layer.cornerRadius = Constants.cornerRadius
        self.makeButton.layer.shadowColor = UIColor.black.cgColor
        self.modelButton.layer.shadowColor = UIColor.black.cgColor
        self.makeButton.layer.shadowRadius = 2
        self.modelButton.layer.shadowRadius = 2
        self.makeButton.layer.shadowOpacity = 0.6
        self.modelButton.layer.shadowOpacity = 0.6
        self.makeButton.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        self.modelButton.layer.shadowOffset = CGSize.init(width: 0, height: 1)
        
        // Localize texts
        self.titleLabel.text = NSLocalizedString("CarList.Filter", comment: "")
        self.makeButton.setTitle(NSLocalizedString("CarList.Filter.Make", comment: ""), for: .normal)
        self.modelButton.setTitle(NSLocalizedString("CarList.Filter.Model", comment: ""), for: .normal)
    }
    
    @IBAction func didTapMake(_ sender: Any) {
    }
    
    @IBAction func didTapModel(_ sender: Any) {
    }
}
