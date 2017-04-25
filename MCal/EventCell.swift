//
//  EventCell.swift
//  MCal
//
//  Created by Maahi on 22/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit

class EventCell: UITableViewCell {

    
    
    @IBOutlet weak var viewEventtype: UIView!
    @IBOutlet weak var lblEventtype: UILabel!
    @IBOutlet weak var viewDetails: UIView!
    
    @IBOutlet weak var lblStrtDatetime: UILabel!
    @IBOutlet weak var lblEndDatetime: UILabel!
    
    @IBOutlet weak var txtViewEventAddress: UITextView!
    @IBOutlet weak var txtViewEventTitle: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
