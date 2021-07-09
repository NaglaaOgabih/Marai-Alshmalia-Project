//
//  AskViewController.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 27/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import Alamofire


class AskViewController: UIViewController {
    var asksArray : [Ask] = []
    @IBOutlet weak var askTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
         navigationItem.backBarButtonItem?.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        askTableView.separatorStyle = .none
        askTableView.tableFooterView = UIView()
        askaAPI()
        
    }
    func askaAPI() {
        Request.startAnimating(view: self.view)
        let decoder = JSONDecoder()
        let params:[String:Any] = [:]
        let headers: HTTPHeaders = ["Lang": "ar" , "ApiToken": AppConstant.Token ?? ""]
        Request.req(url: URLs.asks, headers: headers, params: params, meth: .get, completion: { (data, error) in
            if let error = error {
                print(error.localizedDescription)
            }
            if let data = data {
                
                do {
                    let decodedData = try decoder.decode(AsksData.self, from: data)
                    Request.stopAnimating(view: self.view)
                    DispatchQueue.main.async {
                        self.askTableView.reloadData()
                    }
                    switch decodedData.key {
                    case "success":
                        self.asksArray = decodedData.data
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
extension AskViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return asksArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AskTableViewCell
        cell.setDataToView(model: asksArray[indexPath.row])
        cell.index = indexPath.row
        cell.delegate = self
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        asksArray[indexPath.row].isExpanded = !(asksArray[indexPath.row].isExpanded ?? false)
        self.askTableView.reloadData()
    }
    
}
extension AskViewController : showAnswerDelegate{
    func answerTableViewCellWith(index: Int) {
        asksArray[index].isExpanded = !(asksArray[index].isExpanded ?? false)
        self.askTableView.reloadData()
    }
    
//    func answerTableViewCell(_ cell: AskTableViewCell) {
////                cell.showAction = {
//            cell.switchAnswer = !cell.switchAnswer
//            if cell.switchAnswer == true{
//                cell.showBtn.setImage(UIImage(named: "dropup"), for: .normal)
//                cell.answeStack.isHidden = false
//            }else{
//                cell.showBtn.setImage(UIImage(named: "drop"), for: .normal)
//                cell.answeStack.isHidden = true
//            }
////        }
//    }
}
