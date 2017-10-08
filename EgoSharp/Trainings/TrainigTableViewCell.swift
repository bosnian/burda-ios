//
//  TrainigTableViewCell.swift
//  EgoSharp
//
//  Created by Ammar Hadzic on 10/8/17.
//  Copyright © 2017 Ammar Hadzic. All rights reserved.
//

import UIKit

class TrainigTableViewCell: UITableViewCell {

    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var machineLabel: UILabel!
    @IBOutlet weak var partnerResultLabel: UILabel!
    @IBOutlet weak var partnerMachineLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
