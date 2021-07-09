//
//  ReciverTableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 28/03/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import PaddingLabel

class ReciverTableViewCell: UITableViewCell {
    @IBOutlet weak var reciverMsg: UILabel!
    @IBOutlet weak var leftConstrain: NSLayoutConstraint!
    @IBOutlet weak var rightConstrain: NSLayoutConstraint!
    //    imgView.kf.setImage(with: URL(string: staticImageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))
//    view.addSubview(myImageView)
    override func awakeFromNib() {
        super.awakeFromNib()
//        reciverMsg.leftInset = 7.0
//        reciverMsg.cont

//        reciverMsg.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: reciverMsg.frame.height))
//        reciverMsg.leftViewMode = .always
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
