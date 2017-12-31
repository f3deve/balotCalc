//
//  SlideMenuTableViewCell.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 11/26/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit

class SlideMenuTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cell_1Label: UILabel!
    @IBOutlet weak var cell_2Label: UILabel!
    @IBOutlet weak var cell_3Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
