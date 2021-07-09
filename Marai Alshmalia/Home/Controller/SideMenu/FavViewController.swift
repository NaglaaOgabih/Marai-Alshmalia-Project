//
//  FavViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 25/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Cosmos
import Alamofire
class FavViewController: UIViewController {
    @IBOutlet weak var favTableView: UITableView!
    var dataArray : [Datum] = []
    var SignInToken = SignInViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        favAPI()
    }
     
    @IBAction func notificationBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
              self.navigationController?.pushViewController(vc!, animated: true)
    }
    func favAPI() {
            Request.startAnimating(view: self.view)
            let decoder = JSONDecoder()
            let params:[String:Any] = [:]
            let headers: HTTPHeaders = ["Lang": "ar", "ApiToken": AppConstant.Token ?? "" ]
            Request.req(url: URLs.showFav, headers: headers, params: params, meth: .get, completion: { (data, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                if let data = data {
                    
                    do {
                        let decodedData = try decoder.decode(FavData.self, from: data)
                        Request.stopAnimating(view: self.view)
                        print(data)
                        
                        switch decodedData.key {
                        case "success":
                            self.dataArray = decodedData.data
                            DispatchQueue.main.async {
                                self.favTableView.reloadData()
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
                
            )}
}

extension FavViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavTableViewCell
        let urlImg = dataArray[indexPath.row].image
        cell.imageView!.kf.setImage(with: URL(string: urlImg))
        cell.productName.text = dataArray[indexPath.row].name
        cell.stars.rating = Double(dataArray[indexPath.row].avgRate)
        cell.rateTxt.text = "(\(dataArray[indexPath.row].countRate))"
//        cell.productPrice.text =
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 161
    }
    
}
