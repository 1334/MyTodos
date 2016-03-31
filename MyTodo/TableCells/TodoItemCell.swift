//
//  TodoTableViewCell.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

class TodoItemCell : UITableViewCell {
    
    @IBOutlet var doneButton: UIButton?
    @IBOutlet var titleLabel: UILabel?

    override func awakeFromNib() {
        doneButton?.setTitle(nil, forState: .Normal)
        doneButton?.setBackgroundImage(StyleKit.imageOfCheck(done: false), forState: UIControlState.Normal)
        doneButton?.setBackgroundImage(StyleKit.imageOfCheck(done: true), forState: UIControlState.Selected)
    }
}