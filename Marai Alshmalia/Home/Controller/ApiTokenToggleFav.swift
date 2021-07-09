//
//  ApiTokenToggleFav.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 25/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
import Alamofire
//func favAPI() {
//      let decoder = JSONDecoder()
//    var SignInToken = SignInViewController()
//      let params:[String:Any] = [:]
//      let headers: HTTPHeaders = ["Lang": "ar", "ApiToken": SignInToken.tokenId ]
//      Request.req(url: URLs.showFav, headers: headers, params: params, meth: .get, completion: { (data, error) in
//          if let error = error {
//              print(error.localizedDescription)
//          }
//          if let data = data {
//              
//              do {
//                  let decodedData = try decoder.decode(FavData.self, from: data)
//                  print(data)
//                  
//                  switch decodedData.key {
//                  case "success":
//                   
//                  default:
//                      print(error!)
//                      let errorValue = try decoder.decode(ErrorResponseModel.self, from: data)
//                      print(errorValue.msg as Any)
//                  }
//              } catch {
//                  print(error)
//              }
//              
//          }
//      }
//          
//      )}
