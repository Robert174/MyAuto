//
//  RepairTableViewCell.swift
//  My Auto
//
//  Created by Роберт Райсих on 17/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit

class RepairTableViewCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var paidLabel: UILabel!
    @IBOutlet weak var serviceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
