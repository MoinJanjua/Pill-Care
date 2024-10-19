//
//  SettingTableViewCell.swift
//  PillCare
//
//  Created by Moin Janjua on 15/08/2024.
//

import UIKit

class SettingTableViewCell: UITableViewCell {

    @IBOutlet weak var cView: UIView!
    
    @IBOutlet weak var s_Image: UIImageView!
    @IBOutlet weak var s_Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cView.layer.cornerRadius = 12
        
    // Set up shadow properties
        cView.layer.shadowColor = UIColor.black.cgColor
        cView.layer.shadowOffset = CGSize(width: 0, height: 2)
        cView.layer.shadowOpacity = 0.3
        cView.layer.shadowRadius = 4.0
        cView.layer.masksToBounds = false

      // Set background opacity
        cView.alpha = 1.5 // Adjust opacity as needed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
