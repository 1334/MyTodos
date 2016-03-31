//
//  UIButtonExtension.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    func performAction() {
        self.sendActionsForControlEvents(.TouchUpInside)
    }
    
}
