//
//  MaxiCell.swift
//  MCal
//
//  Created by Maahi on 30/04/17.
//  Copyright © 2017 Maahi. All rights reserved.
//

import UIKit

class MaxiCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnMSG: UIButton!
    @IBOutlet weak var btnMAIL: UIButton!
    @IBOutlet weak var btnCALL: UIButton!
    @IBOutlet weak var btnADD: UIButton!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
