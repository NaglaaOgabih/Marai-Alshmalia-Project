//
//  PickedImgTableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 07/04/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

class PickedImgTableViewCell: UITableViewCell {
    @IBOutlet weak var pickedImgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.pickedImgView.image = nil
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
