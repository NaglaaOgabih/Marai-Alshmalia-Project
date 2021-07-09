//
//  SignInViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 12/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
import SwiftMessages
import SwiftKeychainWrapper
class SignUpViewController: UIViewController {
    
    var signUpArray: DataClass?
    var validation = Validation()
    var agreeButton: Bool = false
    
    @IBOutlet weak var psddEyeBtn: UIButton!
    @IBOutlet weak var confirmPassEyeBtn: UIButton!
    @IBOutlet weak var termsAndConditions: UIButton!
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    
    @IBOutlet weak var phoneTxtField: UITextField!
    
    @IBOutlet weak var passText: UITextField!
    @IBOutlet weak var confirmTxtField: UITextField!
    @IBOutlet weak var agreeBtn: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        psddEyeBtn.setImage(passText.isSecureTextEntry ? #imageLiteral(resourceName: "favo") : #imageLiteral(resourceName: "eye"), for: .normal)
        confirmPassEyeBtn.setImage(confirmTxtField.isSecureTextEntry ? #imageLiteral(resourceName: "favo") : #imageLiteral(resourceName: "eye"), for: .normal)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        let myNormalAttributedTitle = NSAttributedString(string: NSLocalizedString("Terms And Conditions", comment: "").localized(),attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue ])
        termsAndConditions.setAttributedTitle(myNormalAttributedTitle, for: .normal)
        let attributedTitle = NSAttributedString(string: NSLocalizedString("Sign In", comment: "").localized(),attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue ])
             signInButton.setAttributedTitle(attributedTitle, for: .normal)
    }
    @IBAction func agreeButton(_ sender: UIButton) {
        if sender.isSelected {
            sender.setBackgroundImage(UIImage(named: "checkon"), for: .normal)
            agreeButton = true
        } else {
            sender.setBackgroundImage(UIImage(named: "checkof"), for:.normal)
            agreeButton = false
            
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func passwordEyeBtnPressed(_ sender: Any) {
        passText.isSecureTextEntry = !passText.isSecureTextEntry
        psddEyeBtn.setImage(passText.isSecureTextEntry ? #imageLiteral(resourceName: "favo") : #imageLiteral(resourceName: "eye"), for: .normal)
    }
    @IBAction func confirmPassEyeBtnPressed(_ sender: Any) {
        confirmTxtField.isSecureTextEntry = !confirmTxtField.isSecureTextEntry
        confirmPassEyeBtn.setImage(confirmTxtField.isSecureTextEntry ? #imageLiteral(resourceName: "favo") : #imageLiteral(resourceName: "eye"), for: .normal)
        
    }
    @IBAction func SignInBtnPressed(_ sender: Any) {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    @IBAction func countinueBtnPressed(_ sender: Any) {
        if check() == true{
            signUpAPI()
        }
    }
    
    func check() -> Bool{
        guard let _ = userName.text, !(userName.text?.isEmpty)! else {
            self.validation.showMessages(msg: NSLocalizedString("EnterUserName", comment: "").localized())
            return false
        }
        guard let userEmail = emailTxtField.text, !(emailTxtField.text?.isEmpty)! else {
            self.validation.showMessages(msg: NSLocalizedString("EnterEmail", comment: "").localized())
            return false
        }
        let isValidation = self.validation.validationEmail(email: userEmail)
        if isValidation == false{
            self.validation.showMessages(msg: NSLocalizedString("EnterRightEmail", comment: "").localized())
            return false
        }
        guard let _ = phoneTxtField.text, !(phoneTxtField.text?.isEmpty)! else {
            self.validation.showMessages(msg: NSLocalizedString("EnterPhoneNum", comment: "").localized())
            return false
        }
        guard let userPass = passText.text,  !(passText.text?.isEmpty)! else {
            self.validation.showMessages(msg: NSLocalizedString("EnterPassword", comment: "").localized())
            return false
        }
        guard let confirmPass = confirmTxtField.text,!(confirmTxtField.text?.isEmpty)!else  {
            self.validation.showMessages(msg: NSLocalizedString("ReEnterPass", comment: "").localized())
            return false
        }
        let isValidationPass = self.validation.validatPass(pass1: userPass, pass2: confirmPass)
        if isValidationPass == false{
            self.validation.showMessages(msg: NSLocalizedString("PassNotMatch", comment: "").localized())
            return false
        }
        if agreeButton == false{
            self.validation.showMessages(msg: NSLocalizedString("agreeConditions", comment: "").localized())
            return false
        }
        return true
    }
    
    func signUpAPI() {
        let decoder = JSONDecoder()
        let params:[String:Any] = ["name": userName.text! ,"email": emailTxtField.text! ,"phone": phoneTxtField.text!,"password": passText.text! ]
        let headers: HTTPHeaders = ["Lang": "ar"]
        
        Request.req(url: URLs.signUp, headers: headers, params: params, meth: .post, completion: { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                
                do {
                    let decodedData = try decoder.decode(SignUpData.self, from: data)
                    print(data)
                    if self.check() == true {
                        switch decodedData.key {
                        case "success":
                            self.signUpArray = decodedData.data
                            
                            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpCodeViewController") as? SignUpCodeViewController
                            vc?.userIdData = self.signUpArray?.userID
                            self.navigationController?.pushViewController(vc!, animated: true)
                        default:
                            let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                            self.validation.showMessages(msg: errorValue.msg ?? NSLocalizedString("SomethingWrong", comment: "").localized())
                            print(errorValue.msg as Any)
                            
                        }
                    }else{
                        print(error?.localizedDescription as Any)
                    }
                } catch {
                    print(error)
                }
                
            }
        }
        )}
}
