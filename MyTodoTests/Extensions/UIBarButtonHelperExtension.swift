//
//  UIBarButtonHelperExtension.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

extension UIKit.UIBarButtonItem {
    func performAction() {
        UIApplication.sharedApplication().sendAction(self.action, to: self.target, from: self, forEvent: nil)
    }
    
}