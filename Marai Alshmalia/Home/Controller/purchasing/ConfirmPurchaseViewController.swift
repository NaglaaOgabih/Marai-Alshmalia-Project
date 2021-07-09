//
//  ConfirmPurchaseViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 07/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

class ConfirmPurchaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    @IBAction func continueBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "SendTransferViewController") as? SendTransferViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    
}
