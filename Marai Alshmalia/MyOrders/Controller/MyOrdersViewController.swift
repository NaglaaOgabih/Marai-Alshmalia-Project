//
//  MyOrdersViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 08/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

class MyOrdersViewController: UIViewController {
    @IBOutlet weak var newOrdersVC: UIView!
    @IBOutlet weak var finishedOrdersVC: UIView!
    @IBOutlet weak var segmant: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
             navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
              navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)

                finishedOrdersVC.isHidden = true
        
    }
    
    @IBAction func segmentedControlPressed(_ sender: Any) {
        
        if segmant.selectedSegmentIndex == 0 {
            newOrdersVC.isHidden = false
            finishedOrdersVC.isHidden = true
            
        }else{
            finishedOrdersVC.isHidden = false
            newOrdersVC.isHidden = true
            
        }
        
    }
    
    
}
