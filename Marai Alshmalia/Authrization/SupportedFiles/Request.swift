//
//  Alamofire.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 06/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
import Alamofire
import NVActivityIndicatorView

class Request {
    static func req(url: String,headers:HTTPHeaders?, params:[String:Any]?,meth: HTTPMethod, completion:@escaping (Data?,Error?) -> Void) {
        guard  let url = URL(string: url) else {
            print("not valid url")
            return
        }
        AF.request(url,
                   method: meth,
                   parameters: params,
                   encoding: URLEncoding.default,
                   headers: headers).responseJSON { response in
                    switch response.result {
                        
                    case .success( _):
//                        print(response.value)
                        completion(response.data,nil)
                        
                    case .failure(let error):
                        completion(nil,error)
                    }
        }
        
    }
     static var indicator : NVActivityIndicatorView = {
        let indicator = NVActivityIndicatorView(frame: CGRect.init(x: 0, y: 0, width: 60, height: 50), type: .lineSpinFadeLoader, color: .darkGray, padding: .none)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: 40),
            indicator.heightAnchor.constraint(equalToConstant: 40),
        ])
        return indicator
    }()
     static func startAnimating(view : UIView){
        view.isUserInteractionEnabled = false
        indicator.startAnimating()
        view.addSubview(indicator)
     NSLayoutConstraint.activate([
                       indicator.widthAnchor.constraint(equalToConstant: 40),
                       indicator.heightAnchor.constraint(equalToConstant: 40),
                       indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                       indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
                   ])
        
    }
    static func stopAnimating(view : UIView) {
        indicator.stopAnimating()
        indicator.removeFromSuperview()
        view.isUserInteractionEnabled = true

    }
}
