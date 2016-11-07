//
//  AttendancePickerTableViewCell.swift
//  SUSquare
//
//  Created by Marcus Vinicius Kuquert on 21/10/16.
//  Copyright © 2016 AGES. All rights reserved.
//

import UIKit
protocol AttendancePickerTableViewCellDelegate {
    func didTapDoneButton(cell: AttendancePickerTableViewCell, pickerView: UIPickerView, selectedRow: Int)
}

final class AttendancePickerTableViewCell: UITableViewCell {

    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var progressImageView: UIImageView!
    
    var delegate: AttendancePickerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doneButton.addTarget(self, action: #selector(didTapButton), for: UIControlEvents.touchUpInside)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func didTapButton(button: UIButton) {
        let row = pickerView.selectedRow(inComponent: 0)
        delegate?.didTapDoneButton(cell: self, pickerView: pickerView, selectedRow: row)
    }

}
