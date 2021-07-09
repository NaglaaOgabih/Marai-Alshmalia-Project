//
//  IntroCell.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 07/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
class IntroCell: UICollectionViewCell {
    @IBOutlet weak var imgIntro: UIImageView!
    
    @IBOutlet weak var descLabel: UILabel!
    
    @IBOutlet weak var pageView: UIPageControl!
    
    @IBOutlet weak var prevButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var logIn: UIButton!
    @IBOutlet weak var asGuest: UIButton!
    
    
    var nextAction : (()->())?
    var skipAction : (()->())?

    func configureCell(with item : introData){
        
        
    }
    
    
    @IBAction func nextBtnPressed(_ sender: Any) {
        nextAction?()
    }
    @IBAction func prevBtnPressed(_ sender: Any) {
        skipAction?()
    }
    
}
