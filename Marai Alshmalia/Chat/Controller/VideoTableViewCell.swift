//
//  VideoTableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 08/04/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
class VideoTableViewCell: UITableViewCell {
    @IBOutlet weak var videoPlay: UIImageView!
    @IBOutlet weak var videoImg: UIImageView!
    var playAction : (() -> ())?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    @IBAction func videoBtnPressed(_ sender: Any) {
//        playAction?()
//    
////
////        if let videoURL = videoURL{
////          let player = AVPlayer(URL: videoURL)
////
////          let playerViewController = AVPlayerViewController()
////          playerViewController.player = player
////
////          presentViewController(playerViewController, animated: true) {
////            playerViewController.player!.play()
////          }
////        }
//
//        
//    }
//    

}
