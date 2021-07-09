//
//  FinishedDetailViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 09/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
import Cosmos

class FinishedDetailViewController: UIViewController {
    @IBOutlet weak var orderNum: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var paymentWay: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var quantity: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var starsating: CosmosView!
    static var productNameValue : String?
    static var priceValue : Int = 0
    static var quantityValue : Int = 0
    static var sizeValue : String?
    var orderDetailData : OrderDataNew?
    var userRate : Double?
    var productId : Int?
    var validation = Validation()
    override func viewDidLoad() {
        super.viewDidLoad()
        orderDetailApi()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        starsating.didTouchCosmos = { rating in
            self.userRate = rating
            self.rateApi()
        }
    }
    static func setValues(productName: String, price: Int, quantity:Int, Size: String){
        productNameValue = productName
        priceValue = price
        quantityValue = quantity
        sizeValue = Size
    }
    func orderDetailApi(){
        Request.startAnimating(view: self.view)
        let decoder = JSONDecoder()
        let params:[String:Any] = [:]
        let headers: HTTPHeaders = ["Lang": "ar"]
        Request.req(url: URLs.orderDetail , headers: headers, params: params, meth: .get) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                do {
                    let productDataDecoded = try decoder.decode(OrderDetailModel.self, from: data)
                    Request.stopAnimating(view: self.view)
                    switch productDataDecoded.key {
                    case "success":
                        self.orderDetailData = productDataDecoded.data.orderData
                        self.orderNum.text = "\(self.orderDetailData!.orderNum)"
                        self.orderDate.text = "\(self.orderDetailData!.deliveryDate)"
                        self.paymentWay.text = "\(self.orderDetailData!.payType)"
                        self.totalPrice.text = "\(self.orderDetailData!.orderTotal)"
                        self.productName.text = OrderDetailViewController.productNameValue
                        self.price.text = "\(String(describing: OrderDetailViewController.priceValue))"
                        self.quantity.text = "\(String(describing: OrderDetailViewController.quantityValue))"
                        self.size.text = OrderDetailViewController.sizeValue
                        self.productId = self.orderDetailData?.orderID
                        
                    default:
                        print(error!)
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        print(errorValue.msg as Any)
                    }
                } catch {
                    print(error)
                }
                
            }
        }
        
    }
    func rateApi(){
        let decoder = JSONDecoder()
        let params:[String:Any] = ["rated_id": productId! , "rate": userRate! , "comment": "" ]
        let headers: HTTPHeaders = ["Lang": "ar" , "ApiToken": AppConstant.Token ?? ""]
        Request.req(url: URLs.rate , headers: headers, params: params, meth: .post) { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                
                do {
                    print(self.productId)
                    print(self.userRate)
                    let productDataDecoded = try decoder.decode(AddToCartModel.self, from: data)
                    switch productDataDecoded.key {
                    case "success":
//                        self.starsating.settings.updateOnTouch = false
                        self.validation.showMessagesSuccess(msg: "Thank you!")
                    default:
                        print(error?.localizedDescription)
                        let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
                        print(errorValue.msg as Any)
                        
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
        }
        
    }
    
    
    
}
