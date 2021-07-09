//
//  AppDelegate.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 06/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Localize_Swift
import iOSDropDown
import IQKeyboardManagerSwift
import GoogleMaps
import GooglePlaces
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //      ChatStoryboard
        
        
        
        if let rootViewController = self.window?.rootViewController as? UINavigationController {
            
            let storyboard = UIStoryboard(name: "ChatStoryboard", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
//            self.window?.rootViewController = viewController
            rootViewController.pushViewController(viewController, animated: true)
        }
            
            //            let story = UIStoryboard(name: "Main", bundle:nil)
            //            let vc = story.instantiateViewController(withIdentifier: "NewViewController") as! NewViewController
            //            UIApplication.shared.windows.first?.rootViewController = viewController
            //            UIApplication.shared.windows.first?.makeKeyAndVisible()
            //            let appDelegate = UIApplication.shared.delegate as! AppDelegat
            //            let appDelegate = UIApplication.shared.delegate
            //            appDelegate.window?.rootViewController = viewController
            //
            //            let mainStoryBoard = UIStoryboard(name: "Main", bundle: nil)
            //            let redViewController = mainStoryBoard.instantiateViewController(withIdentifier: "respectiveIdentifier") as! ViewController
            //            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //        if AppConstant.isLoggedIn == true{
            //            if let rootViewController = self.window?.rootViewController as? UINavigationController {
            //                let storyboard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
            //                let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            //                rootViewController.pushViewController(viewController, animated: true)
            //            }
            //        }
            //        if Localize.currentLanguage() == "en"{
            //            UIView.appearance().semanticContentAttribute = .forceLeftToRight
            //     UITextField.appearance().textAlignment = .left
            //               DropDown.appearance().textAlignment = .left
            ////     DropDown.appearance() = .left
            //        }else if Localize.currentLanguage() == "ar"{
            //            UIView.appearance().semanticContentAttribute = .forceRightToLeft
            //            UITextField.appearance().textAlignment = .right
            //                 DropDown.appearance().textAlignment = .right
            //
            //        }
            //        }
            GMSServices.provideAPIKey("AIzaSyD5eKqs2_QBnxgMePLiEmBpz7WXr_aPuFA")
            GMSPlacesClient.provideAPIKey("AIzaSyD5eKqs2_QBnxgMePLiEmBpz7WXr_aPuFA")
            IQKeyboardManager.shared.enable = true
            IQKeyboardManager.shared.enableAutoToolbar = false
            IQKeyboardManager.shared.shouldResignOnTouchOutside = true
            return true
        }
        
    
}
