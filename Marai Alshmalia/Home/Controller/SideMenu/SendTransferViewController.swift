//
//  SendTransferViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 31/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire

class SendTransferViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var pickedImg : UIImage?
    var validation = Validation()
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var bankNum: UITextField!
    @IBOutlet weak var bankName: UITextField!
    
    @IBOutlet weak var selectImgTxt: UITextField!
    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
//        userName.placeholder = NSLocalizedString("Enter account user name", comment: "").localized()
//        bankNum.placeholder = NSLocalizedString("Enter bank number here", comment: "").localized()
//        bankName.placeholder = NSLocalizedString("Write transferred bank name here", comment: "").localized()
//        selectImgTxt.placeholder = NSLocalizedString("Select Image", comment: "").localized()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func chooseImg(_ sender: Any) {
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
        imgView.image = image
        picker.dismiss(animated: true, completion: nil)
        
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        
    }
    func askaAPI() {
        Request.startAnimating(view: self.view)
        let params:[String:Any] = ["bank_name": bankName.text!, "account_name": userName.text! , "account_number": bankNum.text! , "amount": "5" ]
        let headers: HTTPHeaders = ["Lang": "ar" , "ApiToken": AppConstant.Token ?? ""]
        AF.upload(
            multipartFormData: { multipartFormData in
                multipartFormData.append(self.pickedImg!.jpegData(compressionQuality: 0.5)!, withName: "image" , fileName: "file.jpeg", mimeType: "image/jpeg")
                if params != nil{
                    for (key,value) in params{
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
        },
            to: URLs.sendTransfer, method: .post , headers: headers)
            .response { resp in
                //                print(resp)
                
        }
        
    }
}
