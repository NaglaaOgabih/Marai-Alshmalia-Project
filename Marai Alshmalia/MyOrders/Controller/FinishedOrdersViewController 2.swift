//
//  FinishedOrdersViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 08/02/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire

class FinishedOrdersViewController: UIViewController {
    var productData : [ProductsDatum] = []
    @IBOutlet weak var newOrderTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newOrderTableView.tableFooterView = UIView()
        //        newOrderTableView.separatorStyle = .none
        orderDetailApi()
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
                        print("success")
                        self.productData = productDataDecoded.data.productsData
                        DispatchQueue.main.async {
                            self.newOrderTableView.reloadData()
                        }
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
}
extension FinishedOrdersViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = newOrderTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewOrdersTableViewCell
        //        let urlImg = productData![indexPath.row].productImage
        //        cell.imageView!.kf.setImage(with: URL(string: urlImg))
        cell.orderNum.text = "\(String(describing: productData[indexPath.row].productID))"
        print("\(String(describing: productData[indexPath.row].productID))")
        cell.price.text = "\(String(describing: productData[indexPath.row].productTotal))"
        cell.productNum.text = "\(String(describing: productData[indexPath.row].productQuantity))"
        OrderDetailViewController.setValues(productName: (productData[indexPath.row].productName), price: productData[indexPath.row].productTotal, quantity: (productData[indexPath.row].productQuantity),
                                            Size: productData[indexPath.row].sizeName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "FinishedDetailViewController") as? FinishedDetailViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

