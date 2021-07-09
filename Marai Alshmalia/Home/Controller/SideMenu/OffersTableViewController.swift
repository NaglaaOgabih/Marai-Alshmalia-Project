//
//  OffersTableViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 26/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
class OffersTableViewController: UIViewController  {
    var offersArray : [Offers] = []
    @IBOutlet weak var offersTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
           navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        offersAPI()
    }
    @IBAction func notificationBtnPressed(_ sender: Any) {
        let vc = UIStoryboard.init(name: "HomeStoryboard", bundle: Bundle.main).instantiateViewController(withIdentifier: "NotificationViewController") as? NotificationViewController
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    func offersAPI() {
             Request.stopAnimating(view: self.view)
             let decoder = JSONDecoder()
             let params:[String:Any] = [:]
             let headers: HTTPHeaders = ["Lang": "ar"]
             Request.req(url: URLs.offers, headers: headers, params: params, meth: .get, completion: { (data, error) in
                 if let error = error {
                     print(error.localizedDescription)
                 }
                 if let data = data {
                     
                     do {
                         let decodedData = try decoder.decode(OffersData.self, from: data)
                         Request.stopAnimating(view: self.view)
                         switch decodedData.key {
                         case "success":
                             self.offersArray = decodedData.data
                             DispatchQueue.main.async {
                                 self.offersTableView.reloadData()
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

    // MARK: - Table view data source
    extension OffersTableViewController: UITableViewDataSource, UITableViewDelegate{
        
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return offersArray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OffersTableViewCell
            let imgUrl = offersArray[indexPath.row].image
            cell.offersImg.kf.setImage(with: URL(string: imgUrl))
            return cell
        }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 170
        }

}

