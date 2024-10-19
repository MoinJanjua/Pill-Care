//
//  AddMedsCollectionViewCell.swift
//  PillCare
//
//  Created by Moin Janjua on 13/08/2024.
//

import UIKit

class AddMedsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var curveView: UIView!
    @IBOutlet weak var Add_Meds_Image: UIImageView!
    @IBOutlet weak var Meds_labelNames: UILabel!
    @IBOutlet weak var Meds_PriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        curveView.layer.cornerRadius = 15
            
        // Set up shadow properties
          layer.shadowColor = UIColor.black.cgColor
          layer.shadowOffset = CGSize(width: 0, height: 2)
          layer.shadowOpacity = 0.3
          layer.shadowRadius = 4.0
          layer.masksToBounds = false

          // Set background opacity
        contentView.alpha = 1.5 // Adjust opacity as needed

    }
}
