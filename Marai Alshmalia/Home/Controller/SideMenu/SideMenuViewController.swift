//
//  SideMenuViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 24/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import SideMenu
import Alamofire
import SwiftKeychainWrapper
class SideMenuViewController: UIViewController {
    var validation = Validation()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exitBtnPressed(_ sender: Any) {
        aboutAPI()
    }
    @IBAction func profileBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "ProfilevViewController") as? ProfilevViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func favBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "FavViewController") as? FavViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func offersBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "OffersTableViewController") as? OffersTableViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func balanceBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "WalletBalanceViewController") as? WalletBalanceViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func asksBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "AskViewController") as? AskViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func aboutBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "AboutViewController") as? AboutViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func languageBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "LanguageViewController") as? LanguageViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func suggestionsBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "SuggestionsViewController") as? SuggestionsViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func testConditions(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "SendTransferViewController") as? SendTransferViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    func aboutAPI(){
        //  Request.startAnimating(view: view)
        let decoder = JSONDecoder()
        let params:[String:Any] = [:]
        let headers: HTTPHeaders = ["Lang": "ar"]
        Request.req(url: URLs.about, headers: headers, params: params, meth: .get, completion: { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                
                do {
                    let decodedData = try decoder.decode(UpdatePass.self, from: data)
                    //                      Request.stopAnimating(view: self.view)
                    switch decodedData.key {
                    case "success":
                        let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
                        let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
                        let appDelegate = UIApplication.shared.delegate as! AppDelegate
                        let nav = UINavigationController(rootViewController: redViewController)
                        appDelegate.window?.rootViewController = nav
                        
                        KeychainWrapper.standard.removeObject(forKey: "token")
                        KeychainWrapper.standard.removeObject(forKey: "isLoggedIn")
                    default:
                        print(error?.localizedDescription as Any)
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        self.validation.showMessages(msg: errorValue.msg ?? NSLocalizedString("SomethingWrong", comment: "").localized())
                        print(errorValue.msg as Any)
                        return
                    }
                } catch {
                    print(error)
                }
                
            }
        }
            
        )
    }
}

