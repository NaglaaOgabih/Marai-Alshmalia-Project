//
//  ChatTableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 28/03/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

class SenderTableViewCell: UITableViewCell {
    @IBOutlet weak var senderMsg: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
