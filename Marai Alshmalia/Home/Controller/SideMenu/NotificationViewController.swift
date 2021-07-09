//
//  NotificationViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 31/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire
class NotificationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        // Do any additional setup after loading the view.
    }
    

    func notificationApi(){
          Request.startAnimating(view: self.view)
          let decoder = JSONDecoder()
          let params:[String:Any] = [:]
          let headers: HTTPHeaders = ["Lang": "ar"]
          Request.req(url: URLs.notificationsPage , headers: headers, params: params, meth: .get) { (data, error) in
              if let error = error {
                  print(error.localizedDescription)
              }
              if let data = data {

                  do {
                      let productDataDecoded = try decoder.decode(NotificationData.self, from: data)
                      Request.stopAnimating(view: self.view)
                      switch productDataDecoded.key {
                      case "success":
                        print("")
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
extension NotificationViewController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NotificationTableViewCell
           return cell
    }
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            tableView.beginUpdates()
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}
