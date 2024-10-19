//
//  TableViewCellMeds.swift
//  PillCare
//
//  Created by Moin Janjua on 15/08/2024.
//

import UIKit

class TableViewCellMeds: UITableViewCell {

    @IBOutlet weak var name_lbl: UILabel!
    @IBOutlet weak var quantity_lbl: UILabel!
    @IBOutlet weak var date_lbl: UILabel!
    @IBOutlet weak var hm_daysLbl: UILabel!
    @IBOutlet weak var curveView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        curveView.layer.cornerRadius = 12
        
    // Set up shadow properties
        curveView.layer.shadowColor = UIColor.black.cgColor
        curveView.layer.shadowOffset = CGSize(width: 0, height: 2)
        curveView.layer.shadowOpacity = 0.3
        curveView.layer.shadowRadius = 4.0
        curveView.layer.masksToBounds = false

      // Set background opacity
        curveView.alpha = 1.5 // Adjust opacity as needed
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
