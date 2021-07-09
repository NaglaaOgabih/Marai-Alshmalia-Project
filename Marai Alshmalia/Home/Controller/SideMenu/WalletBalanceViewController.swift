//
//  WalletBalanceViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 27/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
class WalletBalanceViewController: UIViewController {
    //    var walletData : WalletBalanceData?
    var balanceNum : Double = 0.0
    @IBOutlet weak var balance: UILabel!
    let validation = Validation()
    override func viewDidLoad() {
        super.viewDidLoad()
           navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        balanceAPI()
    }
    
    @IBAction func confirmBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "SendTransferViewController") as? SendTransferViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func balanceAPI() {
        Request.startAnimating(view: self.view)
        let decoder = JSONDecoder()
        let params:[String:Any] = [:]
        let headers: HTTPHeaders = ["Lang": "ar" ,  "ApiToken": AppConstant.Token ?? "" ]
        Request.req(url: URLs.balance, headers: headers, params: params, meth: .get, completion: { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                
                do {
                    let decodedData = try decoder.decode(WalletBalanceData.self, from: data)
                    Request.stopAnimating(view: self.view)
                    switch decodedData.key {
                    case "success":
                        self.balanceNum = decodedData.data.balance
                        self.balance.text = String(self.balanceNum)
                    case "exit":
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        self.validation.showMessages(msg: errorValue.msg ?? NSLocalizedString("SomethingWrong", comment: "").localized())
                        KeychainWrapper.standard.removeObject(forKey: "token")
                        KeychainWrapper.standard.removeObject(forKey: "isLoggedIn")
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
                        
                    default:
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        self.validation.showMessages(msg: errorValue.msg ?? NSLocalizedString("SomethingWrong", comment: "").localized())
                        
                    }
                } catch {
                    print(error)
                }
                
            }
        }
            
        )}
}
