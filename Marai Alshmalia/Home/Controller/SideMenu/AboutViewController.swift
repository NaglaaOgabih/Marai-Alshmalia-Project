//
//  AboutViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 28/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
class AboutViewController: UIViewController {
    var descData : String?
    
    @IBOutlet weak var descLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        aboutAPI()
        // Do any additional setup after loading the view.
    }
    func aboutAPI() {
    Request.startAnimating(view: self.view)
            let decoder = JSONDecoder()
            let params:[String:Any] = [:]
          let headers: HTTPHeaders = ["Lang": "ar"]
            Request.req(url: URLs.about, headers: headers, params: params, meth: .get, completion: { (data, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let data = data {
                    
                    do {
                        let decodedData = try decoder.decode(DescData.self, from: data)
                        Request.stopAnimating(view: self.view)
                        switch decodedData.key {
                        case "success":
                            self.descData = decodedData.data.desc
                            self.descLabel.text = self.descData
                        default:
                            print(error?.localizedDescription as Any)
                            let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                            print(errorValue.msg as Any)
                        }
                    } catch {
                        print(error)
                    }
                    
                }
            }
                
            )}
}
