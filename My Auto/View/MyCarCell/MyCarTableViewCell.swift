//
//  MyCarTableViewCell.swift
//  My Auto
//
//  Created by Роберт Райсих on 12/05/2019.
//  Copyright © 2019 Роберт Райсих. All rights reserved.
//

import UIKit

class MyCarTableViewCell: UITableViewCell {

    @IBOutlet weak var markLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
