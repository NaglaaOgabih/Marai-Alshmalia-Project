//
//  NewOrdersTableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 08/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

class NewOrdersTableViewCell: UITableViewCell {

    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var productNum: UILabel!
    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
