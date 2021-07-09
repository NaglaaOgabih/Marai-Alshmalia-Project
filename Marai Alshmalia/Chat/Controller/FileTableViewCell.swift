//
//  FileTableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 08/04/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

class FileTableViewCell: UITableViewCell {

    @IBOutlet weak var fileTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
