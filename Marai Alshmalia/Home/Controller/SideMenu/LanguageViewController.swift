//
//  LanguageViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 28/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Localize_Swift
import iOSDropDown
class LanguageViewController: UIViewController {
    var arabicIsChecked :Bool?
    var englishIsChecked :Bool?
    
    @IBOutlet weak var arabicBtn: UIButton!
    @IBOutlet weak var englishBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        if Localize.currentLanguage() == "ar"{
            arabicBtn.setImage(UIImage(named: "checkon"), for: .normal)
            englishBtn.setImage(UIImage(named: "checkoff"), for: .normal)
            
        }else if Localize.currentLanguage() == "en"{
            englishBtn.setImage(UIImage(named: "checkon"), for: .normal)
            arabicBtn.setImage(UIImage(named: "checkoff"), for: .normal)
        }
    }
    
    @IBAction func nfBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    @IBAction func arabicBtnPressed(_ sender: Any) {
        arabicBtn.setImage(UIImage(named: "checkon"), for: .normal)
        englishBtn.setImage(UIImage(named: "checkoff"), for: .normal)
        arabicIsChecked = true
        englishIsChecked = false
    }
    @IBAction func englishBtnPressed(_ sender: Any) {
        englishBtn.setImage(UIImage(named: "checkon"), for: .normal)
        arabicBtn.setImage(UIImage(named: "checkoff"), for: .normal)
        englishIsChecked = true
        arabicIsChecked = false
    }
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        if arabicIsChecked == true && Localize.currentLanguage() != "ar"{
            Localize.setCurrentLanguage("ar")
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            UITextField.appearance().textAlignment = .right
            DropDown.appearance().textAlignment = .right
            //            let mainStoryBoard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
            //            let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //            appDelegate.window?.rootViewController = redViewController
            
            let mainStoryBoard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
            let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let nav = UINavigationController(rootViewController: redViewController)
            appDelegate.window?.rootViewController = nav
        }else{
               let mainStoryBoard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
               let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let nav = UINavigationController(rootViewController: redViewController)
               appDelegate.window?.rootViewController = nav
        }
        if englishIsChecked == true && Localize.currentLanguage() != "en"{
            Localize.setCurrentLanguage("en")
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            UITextField.appearance().textAlignment = .left
            DropDown.appearance().textAlignment = .left
 
               let mainStoryBoard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
               let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let nav = UINavigationController(rootViewController: redViewController)
               appDelegate.window?.rootViewController = nav
        }else{
                   
               let mainStoryBoard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
               let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
               let appDelegate = UIApplication.shared.delegate as! AppDelegate
               let nav = UINavigationController(rootViewController: redViewController)
               appDelegate.window?.rootViewController = nav
        }
    }
    
}
