//
//  MenuTableViewCell.swift
//  ios-smartpush-demo
//
//  Created by Carlos Correa on 18/04/2020.
//  Copyright © 2020 Carlos Correa. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {

    
    @IBOutlet weak var menuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
