//
//  AddEditCell.swift
//  MCal
//
//  Created by Maahi on 24/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit

class AddEditCell: UITableViewCell {

    
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    @IBOutlet weak var alldayswitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
