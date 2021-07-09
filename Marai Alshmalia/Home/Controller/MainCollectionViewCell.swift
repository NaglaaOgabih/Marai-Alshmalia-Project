//
//  CollectionViewCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 19/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Cosmos
class MainCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionImg: UIImageView!
    
    @IBOutlet weak var productName: UILabel!
    
    @IBOutlet weak var collectionRate: UILabel!
    
    @IBOutlet weak var stars: CosmosView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func cellData(data: [Product] ,indexPath:IndexPath ,cell: MainCollectionViewCell){
        let imgUrl = data[indexPath.row].image
        cell.collectionImg.kf.setImage(with: URL(string: imgUrl))
        cell.productName.text = data[indexPath.row].sectionName
        cell.collectionRate.text = "(\(data[indexPath.row].countRate))"
        cell.stars.rating = Double(data[indexPath.row].avgRate)
        cell.stars.settings.updateOnTouch = false
        cell.stars.settings.disablePanGestures = true
    }
    
}

