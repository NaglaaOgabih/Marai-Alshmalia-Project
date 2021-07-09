//
//  MessagesModel.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 01/04/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
import UIKit

struct Messages {
    var messageBody : String?
    var img : UIImage?
    var pickedImg : UIImage?
    var lat , long:Double?
    var type : String?
    var pickedVideo : UIImage?
    var fileTitle : String?
    var direction : String? //you or me
}
