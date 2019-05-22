//
//  PetrolTableViewCell.swift
//  My Auto
//
//  Created by Роберт Райсих on 16/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit

class PetrolTableViewCell: UITableViewCell {

    @IBOutlet weak var costLabel: UILabel!
    @IBOutlet weak var pricePerLiterLabel: UILabel!
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
