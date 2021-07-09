//
//  PassCodeViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 13/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
class PassCodeViewController: UIViewController {
    var userIdData : Int?
    var validation = Validation()
    @IBOutlet weak var codeTxt: UITextField!
    
    @IBOutlet weak var newPassTxt: UITextField!
    
    @IBOutlet weak var confirmNewPassTxt: UITextField!
    @IBOutlet weak var sendCodeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        let attributedTitle = NSAttributedString(string: NSLocalizedString("Send code", comment: "").localized(),attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray, NSAttributedString.Key.underlineStyle : NSUnderlineStyle.single.rawValue ])
        sendCodeBtn.setAttributedTitle(attributedTitle, for: .normal)
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
     newPassApi()
    }
    func newPassApi(){
          let decoder = JSONDecoder()
        let params:[String:Any] = ["user_id": userIdData!,"code": codeTxt! ,"new_password": newPassTxt!]
          let headers: HTTPHeaders = ["Lang": "ar"]
          Request.req(url: URLs.newPass, headers: headers, params: params, meth: .post) { (data, error) in
              if let error = error {
                  print(error.localizedDescription)
              }
              if let data = data {
                  do {
                    let decodedData = try decoder.decode(UpdatePass.self, from: data)
                      print(data)
                      switch decodedData.key{
                      case "success":
                        self.validation.showMessages(msg: decodedData.msg)
                          let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
                          self.navigationController?.pushViewController(vc!, animated: true)
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
