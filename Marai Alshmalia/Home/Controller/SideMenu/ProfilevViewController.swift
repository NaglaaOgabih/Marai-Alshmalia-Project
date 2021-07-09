//
//  ProfilevViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 01/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
class ProfilevViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pickedImg : UIImage?
    var validation = Validation()
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var phoneTxt: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        nameTxt.placeholder = NSLocalizedString("Name", comment: "").localized()
//        emailTxt.placeholder = NSLocalizedString("EnterEmail", comment: "").localized()
//               phoneTxt.placeholder = NSLocalizedString("EnterPhoneNum", comment: "").localized()
        aboutAPIGet()
    }
    
    @IBAction func editImgBtnPressed(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action : UIAlertAction) in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Photo Liperary", style: .default, handler: { (action : UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            
            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        actionSheet.addAction(UIAlertAction(title: "cancel", style: .cancel, handler: { (action : UIAlertAction) in
            //            self.present(imagePickerController, animated: true, completion: nil)
            
        }))
        self.present(actionSheet, animated: true, completion: nil)
        
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        pickedImg = image
        profileImg.image = image
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func changePassBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PassCodeViewController") as? PassCodeViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    @IBAction func saveBtnPressed(_ sender: Any) {
        askaAPI()
    }
    
    @IBAction func notificationBtnPressed(_ sender: Any) {
    }
    func check() -> Bool{
        guard let _ = nameTxt.text, !(nameTxt.text?.isEmpty)! else {
            self.validation.showMessages(msg:NSLocalizedString("EnterUserName", comment: "").localized())
            return false
        }
        guard let _ = phoneTxt.text, !(phoneTxt.text?.isEmpty)! else {
            self.validation.showMessages(msg: NSLocalizedString("EnterPhoneNum", comment: "").localized())
            return false
        }
        guard let _ = emailTxt.text, !(emailTxt.text?.isEmpty)! else {
            self.validation.showMessages(msg:NSLocalizedString("EnterEmail", comment: "").localized())
            return false
        }
        return true
    }
    func askaAPI(){
        let params:[String:Any] = ["name": nameTxt.text!, "phone": phoneTxt.text! , "email": emailTxt.text!]
        let headers: HTTPHeaders = ["Lang": "ar" , "ApiToken": AppConstant.Token ?? ""]
        if self.check() == true {
        AF.upload(
            multipartFormData: { multipartFormData in
                if self.pickedImg != nil{
                    multipartFormData.append(self.pickedImg!.jpegData(compressionQuality: 0.5)!, withName: "avatar" , fileName: "file.jpeg", mimeType: "image/jpeg")
                }
                    for (key,value) in params{
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
        },
            to: URLs.profileUpdate, method: .post , headers: headers)
            .response { resp in
                self.validation.showMessagesSuccess(msg: NSLocalizedString("SaveSuccessfully", comment: "").localized())
        }
        }
    }
    func aboutAPIGet() {
        Request.startAnimating(view: self.view)
        let decoder = JSONDecoder()
        let params:[String:Any] = [:]
        let headers: HTTPHeaders = ["Lang": "ar" ,  "ApiToken": AppConstant.Token ?? "" ]
        Request.req(url: URLs.profile, headers: headers, params: params, meth: .get, completion: { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                
                do {
                    print(AppConstant.Token)
                    let decodedData = try decoder.decode(ProfileData.self, from: data)
                    Request.stopAnimating(view: self.view)
                    switch decodedData.key {
                    case "success":
                        self.nameTxt.text = decodedData.data?.name
                        self.emailTxt.text = decodedData.data?.email
                        self.phoneTxt.text = decodedData.data?.phone
                        let imgUrl = decodedData.data?.avatar
                        self.profileImg.kf.setImage(with: URL(string: imgUrl!))
                        
                    default:
                        print(error?.localizedDescription as Any)
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        self.validation.showMessages(msg: errorValue.msg!)
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
                
            }
        }
            
        )}
}

