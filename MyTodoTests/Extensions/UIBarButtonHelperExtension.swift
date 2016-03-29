//
//  UIBarButtonHelperExtension.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

extension UIControl {


    func type(text: String) {
        if let textfield = self as? UITextField {
            var textFieldText = ""
            if let t = textfield.text {
                textFieldText += t
            }
            textFieldText += text
            textfield.text = textFieldText
            textfield.sendActionsForControlEvents(UIControlEvents.EditingChanged)
        }
    }
    
}