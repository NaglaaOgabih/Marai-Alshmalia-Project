//
//  SignInViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 12/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
import SwiftKeychainWrapper

class SignInViewController: UIViewController {
    @IBOutlet weak var passBtn: UIButton!
    @IBOutlet weak var signInOrEmailTxt: UITextField!
    @IBOutlet weak var PassTxt: UITextField!
    @IBOutlet weak var forgetPassBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
//    var userId : ActiveData?
    var validation = Validation()
    var tokenId : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        passBtn.setImage(PassTxt.isSecureTextEntry ? #imageLiteral(resourceName: "favo") : #imageLiteral(resourceName: "eye"), for: .normal)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        signInOrEmailTxt.text = "7637281923"
        PassTxt.text = "000000"
        let myNormalAttributedTitle = NSAttributedString(string: NSLocalizedString("Forget Password ?", comment: "").localized(),attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue ])
              forgetPassBtn.setAttributedTitle(myNormalAttributedTitle, for: .normal)
        let attributedTitle = NSAttributedString(string: NSLocalizedString("Sign Up", comment: "").localized(),attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue ])
                   signUpBtn.setAttributedTitle(attributedTitle, for: .normal)
    }

    
    @IBAction func signInButton(_ sender: Any) {
        SignInApi()
    }
    
    @IBAction func signUpBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpViewController") as? SignUpViewController
        self.navigationController?.pushViewController(vc!, animated: true)    }
    
    @IBAction func passBtnPressed(_ sender: Any) {
        PassTxt.isSecureTextEntry = !PassTxt.isSecureTextEntry
        passBtn.setImage(PassTxt.isSecureTextEntry ? #imageLiteral(resourceName: "favo") : #imageLiteral(resourceName: "eye"), for: .normal)
    }
    @IBAction func forgetPassBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PhoneNumViewController") as? PhoneNumViewController
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
    func SignInApi(){
        let decoder = JSONDecoder()
        let params:[String:Any] = ["phoneOrMail": signInOrEmailTxt.text! ,"password": PassTxt.text! ,"device_id": "5555","device_type": "ios" ]
        let headers: HTTPHeaders = ["Lang": "ar"]
        Request.req(url: URLs.signIn, headers: headers, params: params, meth: .post) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let decodedData = try decoder.decode(SignInData.self, from: data)
                    switch decodedData.key{
                    case "success":
                        self.tokenId = decodedData.data?.token as! String
                        KeychainWrapper.standard.set(self.tokenId, forKey: "token")
                        KeychainWrapper.standard.set(true, forKey: "isLoggedIn")
                        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                        self.navigationController?.pushViewController(vc!, animated: true)
                        print("success")
                    case "blocked" , "fail":
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        self.validation.showMessages(msg: errorValue.msg ?? NSLocalizedString("SomethingWrong", comment: "").localized())
                        
                    default:
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        self.validation.showMessages(msg: errorValue.msg ?? NSLocalizedString("SomethingWrong", comment: "").localized())
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpCodeViewController") as? SignUpCodeViewController
                        let decodedData = try decoder.decode(NeedActiveModel.self, from: data)
                        vc?.userIdData = decodedData.data?.userID
                        self.navigationController?.pushViewController(vc!, animated: true)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    
    
}
