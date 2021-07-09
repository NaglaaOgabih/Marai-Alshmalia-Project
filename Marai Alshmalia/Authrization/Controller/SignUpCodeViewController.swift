//
//  SignUpCodeViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 13/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper
class SignUpCodeViewController: UIViewController {
    @IBOutlet weak var codeTxtField: UITextField!
    
    @IBOutlet weak var sendCodeBtn: UIButton!
    var userIdData : Int?
    var validation = Validation()
    //    let retrievedString: String? = KeychainWrapper.standard.string(forKey: "myKey")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        codeTxtField.text = "1234"
        let attributedTitle = NSAttributedString(string: NSLocalizedString("Send code", comment: "").localized(),attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue ])
        sendCodeBtn.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        codeApi()
//           let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
//        self.navigationController?.pushViewController(vc!, animated: true)

    }
    
    func codeApi(){
        let decoder = JSONDecoder()
        let params:[String:Any] = ["user_id": userIdData! ,"code": codeTxtField.text! ,"device_id": "5555","device_type": "ios" ]
        let headers: HTTPHeaders = ["Lang": "ar"]
        Request.req(url: URLs.activeCode, headers: headers, params: params, meth: .post) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let decodedData = try decoder.decode(ActiveCodeData.self, from: data)
                    print(data)
                    switch decodedData.key{
                    //home
                    case "success":
                        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                        let saveSuccessful: Bool = KeychainWrapper.standard.set(decodedData.data.userID, forKey: "myKey")
                        print(saveSuccessful)
                        self.navigationController?.pushViewController(vc!, animated: true)
                        print("success")
                    default:
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        self.validation.showMessages(msg: errorValue.msg ?? NSLocalizedString("SomethingWrong", comment: "").localized())
                        print(errorValue.msg as Any)
                    }
                    
                }catch{
                    print(error)
                }
            }
        }
    }
    
    
}
