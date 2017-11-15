//
//  ScoresTableViewCell.swift
//  balotCalc
//
//  Created by Faisal Alkhotaifi on 11/14/17.
//  Copyright © 2017 F3Deve. All rights reserved.
//

import UIKit

class ScoresTableViewCell: UITableViewCell {
    @IBOutlet weak var theirScoresLabel: UILabel!
    @IBOutlet weak var ourScoresLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
