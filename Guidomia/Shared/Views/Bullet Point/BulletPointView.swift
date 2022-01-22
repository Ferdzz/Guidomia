//
//  BulletPointView.swift
//  Guidomia
//
//  Created by Frederic Deschenes on 2022-01-22.
//

import UIKit

class BulletPointView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var pointView: UIView!
    @IBOutlet weak var label: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
    private func commonInit() {
        // Load the design elements from the Xib file
        Bundle.main.loadNibNamed("BulletPointView", owner: self, options: nil)
        // Make sure the contentView is displayed & expands to fill the space
        self.addSubview(contentView)
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        // Configure the rounded bullet point
        self.pointView.layer.cornerRadius = self.pointView.frame.width / 2
        self.pointView.clipsToBounds = false
    }
    
    public func configure(text: String) {
        self.label.text = text
    }
}
