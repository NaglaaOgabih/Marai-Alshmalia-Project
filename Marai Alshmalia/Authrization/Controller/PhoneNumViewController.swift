//
//  PhoneNumViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 13/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
class PhoneNumViewController: UIViewController {
    @IBOutlet weak var phoneNumTxt: UITextField!
    var validation = Validation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
    }
    
    @IBAction func continueBtnPressed(_ sender: Any) {
        phoneNumApi()
    }
    
    func phoneNumApi(){
        let decoder = JSONDecoder()
        let params:[String:Any] = ["phone": phoneNumTxt!]
        let headers: HTTPHeaders = ["Lang": "ar"]
        Request.req(url: URLs.activeCode, headers: headers, params: params, meth: .post) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let decodedData = try decoder.decode(PhoneNumData.self, from: data)
                    print(data)
                    switch decodedData.key{
                    case "success":
                        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PassCodeViewController") as? PassCodeViewController
                        vc?.userIdData = decodedData.data.userID
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
