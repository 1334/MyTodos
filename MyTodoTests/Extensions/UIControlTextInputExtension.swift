//
// Created by Rene Pirringer on 29.03.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
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
    
    func backspace() {
        if let textfield = self as? UITextField {
            if let t = textfield.text {
                if (t.characters.count == 0) {
                    return
                }
                let endIndex = t.endIndex.advancedBy(-1)
                textfield.text = t.substringToIndex(endIndex)
            }
            textfield.sendActionsForControlEvents(UIControlEvents.EditingChanged)
        }
        
    }

}