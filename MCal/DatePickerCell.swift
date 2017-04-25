//
//  DatePickerCell.swift
//  MCal
//
//  Created by Maahi on 24/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit

class DatePickerCell: UITableViewCell {

    @IBOutlet weak var lblStart: UILabel!
    @IBOutlet weak var lblStartDate: UILabel!
    @IBOutlet weak var datepicker: UIDatePicker!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
