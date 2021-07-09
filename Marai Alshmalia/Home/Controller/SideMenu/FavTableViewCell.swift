//
//  FavTableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 25/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Cosmos
class FavTableViewCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var stars: CosmosView!
    @IBOutlet weak var rateTxt: UILabel!
    @IBOutlet weak var productPrice: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
