//
//  Validation.swift
//  Marai Alshmalia
//
//  Created by Naglaa Ogabih on 14/01/2021.
//  Copyright © 2021 NaglaaOgabih. All rights reserved.
//

import Foundation
import SwiftMessages
class Validation {
    func validationEmail(email: String) -> Bool {
        let emailEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let trimmedString = email.trimmingCharacters(in: .whitespaces)
        let validateEmail = NSPredicate(format:"SELF MATCHES %@", emailEx)
        let isValedateEmail = validateEmail.evaluate(with: trimmedString)
        return isValedateEmail
    }
    func validatPass(pass1: String, pass2:String) -> Bool {
        if pass1 == pass2 {
            return true
        }else{
            return false
        }
    }
    func showMessages(msg: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.info)
        view.button?.isHidden = true
        view.configureContent(title: NSLocalizedString("wrong", comment: "").localized(), body: msg)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        SwiftMessages.show(view: view)
    }
    func showMessagesSuccess(msg: String) {
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.button?.isHidden = true
        view.configureContent(title: "", body: msg)
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        SwiftMessages.show(view: view)
    }
}
