//
//  CustomTableViewCell.swift
//  MukilApp
//
//  Created by mohamed on 27/05/15.
//  Copyright (c) 2015 mohamed. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet weak var thumImage : UIImageView!
    @IBOutlet weak var title : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
