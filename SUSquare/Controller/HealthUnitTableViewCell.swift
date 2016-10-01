//
//  HealthUnitTableViewCell.swift
//  SUSquare
//
//  Created by Luis Filipe Campani on 01/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit

class HealthUnitTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblDistance: UILabel!
    @IBOutlet weak var lblHealthUnit: UILabel!
    @IBOutlet weak var lblWaitTime: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblHealthUnit.numberOfLines = 2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
