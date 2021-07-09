//
//  ResetPassordViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 13/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit

class ResetPassordViewController: UIViewController {
    
    
    @IBOutlet weak var passTxt: UITextField!
    @IBOutlet weak var passBtn: UIButton!
    
    @IBOutlet weak var confirmPassTxt: UITextField!
    @IBOutlet weak var confirmPassBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passBtn.setImage(passTxt.isSecureTextEntry ? #imageLiteral(resourceName: "favo") : #imageLiteral(resourceName: "eye"), for: .normal)
        confirmPassBtn.setImage(confirmPassTxt.isSecureTextEntry ? #imageLiteral(resourceName: "favo") : #imageLiteral(resourceName: "eye"), for: .normal)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    @IBAction func passBtnPreesed(_ sender: Any) {
        passTxt.isSecureTextEntry = !passTxt.isSecureTextEntry
        passBtn.setImage(passTxt.isSecureTextEntry ? #imageLiteral(resourceName: "favo") : #imageLiteral(resourceName: "eye"), for: .normal)
    }
    
    
    @IBAction func confirmPassBtn(_ sender: Any) {
        confirmPassTxt.isSecureTextEntry = !confirmPassTxt.isSecureTextEntry
        confirmPassBtn.setImage(confirmPassTxt.isSecureTextEntry ? #imageLiteral(resourceName: "favo") : #imageLiteral(resourceName: "eye"), for: .normal)
    }
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
            self.navigationController?.pushViewController(vc!, animated: true)
    }
    

}
