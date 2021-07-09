//
//  ImgTableViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 04/04/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Kingfisher

class ImgTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        self.imgView.image = nil
    }
    
    func configureCell(with lat : Double , long : Double){
    let Width = 300
    let Height = 300
    let mapImageUrl = "https://maps.googleapis.com/maps/api/staticmap?center="
    let latlong = "\(String(describing:lat)), \( String(describing: long))"
    let mapUrl  = mapImageUrl + latlong
    let size = "&size=" +  "\(Int(Width))" + "x" +  "\(Int(Height))"
    let positionOnMap = "&markers=size:mid|color:red|" + latlong
    let staticImageUrl = mapUrl + size + positionOnMap + "&key=\("AIzaSyD5eKqs2_QBnxgMePLiEmBpz7WXr_aPuFA")&zoom=13"
        print("staticImageUrl")
            print(staticImageUrl)
        imgView.kf.setImage(with: URL(string: staticImageUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!))
    }
    
    
}
