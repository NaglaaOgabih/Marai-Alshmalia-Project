//
//  ViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 17/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

//    var tabBarItem = UITabBarItem()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
         self.navigationController?.navigationBar.shadowImage = UIImage()
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.lightGray], for: .normal)
             UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .selected) 
        let selectedImg1 = UIImage(named: "homeon")?.withRenderingMode(.alwaysOriginal)
        let deSelectedImg1 = UIImage(named: "homeoff")?.withRenderingMode(.alwaysOriginal)
        tabBarItem = self.tabBar.items![0]
        tabBarItem.image = deSelectedImg1
        tabBarItem.selectedImage = selectedImg1
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 7)
        tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tabBarItem.title = NSLocalizedString("Main", comment: "").localized()

          let selectedImg2 = UIImage(named: "caart")?.withRenderingMode(.alwaysOriginal)
        tabBarItem = self.tabBar.items![1]
        tabBarItem.image = selectedImg2
        tabBarItem.selectedImage = selectedImg2
        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.white], for: .normal)
        tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 15)
        tabBarItem.title = NSLocalizedString("Cart", comment: "").localized()

        
                let selectedImg3 = UIImage(named: "orderson")?.withRenderingMode(.alwaysOriginal)
                let deSelectedImg3 = UIImage(named: "orderoff")?.withRenderingMode(.alwaysOriginal)
                tabBarItem = self.tabBar.items![2]
                tabBarItem.image = deSelectedImg3
                tabBarItem.selectedImage = selectedImg3
                tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 7)
                tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        tabBarItem.title = NSLocalizedString("My Orders", comment: "").localized()
                UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 12)

        self.selectedIndex = 0
        
        

    }
}
