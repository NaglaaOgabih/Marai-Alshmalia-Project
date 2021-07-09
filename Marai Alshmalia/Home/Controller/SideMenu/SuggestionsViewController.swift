//
//  SuggestionsViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 28/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
import SafariServices

class SuggestionsViewController: UIViewController {

    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var messageTxt: UITextField!
    var validation = Validation()
    var dataContainer : SiteDataClass?
    var facebookLink : String?
    var twitterLink : String?
    var instaLink : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        SocialmediaApi()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        nameText.placeholder = NSLocalizedString("Name", comment: "").localized()
//        emailTxt.placeholder = NSLocalizedString("Email", comment: "").localized()
//        messageTxt.placeholder = NSLocalizedString("Write your message", comment: "").localized()
    }
    
    @IBAction func twitterBtnPressed(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string: twitterLink!)!)
              present(svc, animated: true, completion: nil)
    }
    @IBAction func facebookBtnPressed(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string: facebookLink!)!)
        present(svc, animated: true, completion: nil)
    }
    @IBAction func instagramBtnPressed(_ sender: Any) {
        let svc = SFSafariViewController(url: URL(string: instaLink!)!)
              present(svc, animated: true, completion: nil)
    }
    @IBAction func whatsappBtnPressed(_ sender: Any) {
    }
    @IBAction func sendMessageBtnPressed(_ sender: Any) {
        SuggestionsApi()
    }
    
    func SuggestionsApi(){
             Request.startAnimating(view: self.view)
             let decoder = JSONDecoder()
        let params:[String:Any] = ["name": nameText.text!, "email": emailTxt.text!, "message": messageTxt.text!]
             let headers: HTTPHeaders = ["Lang": "ar"]
        Request.req(url: URLs.contactUs , headers: headers, params: params, meth: .post) { (data, error) in
                 if let error = error {
                     print(error.localizedDescription)
                 }
                 if let data = data {

                     do {
                         let productDataDecoded = try decoder.decode(UpdatePass.self, from: data)
                         Request.stopAnimating(view: self.view)
                         switch productDataDecoded.key {
                         case "success":
                            self.validation.showMessagesSuccess(msg: NSLocalizedString("messageSend", comment: "").localized())
                            let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as? HomeViewController
                                     self.navigationController?.pushViewController(vc!, animated: true)
                            
                         default:
                             let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                             self.validation.showMessages(msg: productDataDecoded.msg)
                             print(errorValue.msg as Any)
                         }
                     } catch {
                         print(error)
                     }

                 }
             }

         }
    func SocialmediaApi(){
                Request.startAnimating(view: self.view)
                let decoder = JSONDecoder()
           let params:[String:Any] = [:]
                let headers: HTTPHeaders = ["Lang": "ar"]
           Request.req(url: URLs.siteData , headers: headers, params: params, meth: .get) { (data, error) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    if let data = data {

                        do {
                            let decodedData = try decoder.decode(SiteData.self, from: data)
                            Request.stopAnimating(view: self.view)
                            switch decodedData.key {
                            case "success":
                                self.dataContainer = decodedData.data
                                self.facebookLink = self.dataContainer?.socialData.facebook
                                self.twitterLink = self.dataContainer?.socialData.twitter
                                 self.instaLink = self.dataContainer?.socialData.instagram
                            default:
                                print(error!)
                                let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                                self.validation.showMessages(msg: decodedData.msg)
                                print(errorValue.msg as Any)
                            }
                        } catch {
                            print(error)
                        }

                    }
                }

            }
    
}
