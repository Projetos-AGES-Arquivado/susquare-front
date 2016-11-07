//
//  AttendanceTableViewCell.swift
//  SUSquare
//
//  Created by Marcus Vinicius Kuquert on 21/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit
protocol AttendanceTableViewCellDelegate {
    func didTapClearButton(cell: AttendanceTableViewCell)
}

final class AttendanceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var clearButton: UIButton!
    @IBOutlet weak var progressImageView: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var bottomLabel: UILabel!
    var delegate: AttendanceTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearButton.addTarget(self, action: #selector(didTapButton), for: UIControlEvents.touchUpInside)
        clearButton.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func didTapButton(sender: UIButton) {
        delegate?.didTapClearButton(cell: self)
    }
}
