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
    
    typealias TodoItemChangeClosure  = (old:TodoItem, new:TodoItem) -> Void

    @IBOutlet var doneButton: UIButton?
    @IBOutlet var titleLabel: UILabel?
    
    var todoItemChangeClosure: TodoItemChangeClosure?
    
    var todoItem: TodoItem? {
        didSet {
            titleLabel?.text = todoItem?.title
            if let done = todoItem?.done {
                doneButton?.selected = done
            }
        }
    }
    
    
    override func awakeFromNib() {
        doneButton?.setTitle(nil, forState: .Normal)
        doneButton?.setBackgroundImage(StyleKit.imageOfCheck(done: false), forState: UIControlState.Normal)
        doneButton?.setBackgroundImage(StyleKit.imageOfCheck(done: true), forState: UIControlState.Selected)
        doneButton?.addTarget(self, action: #selector(doneButtonPressed), forControlEvents: .TouchUpInside)
    }
    
    
    func doneButtonPressed() {
        if let button = doneButton {
            button.selected = !button.selected
            
            if let todoItem = self.todoItem {
                if let changeClosure = todoItemChangeClosure {
                    changeClosure(old:todoItem, new:todoItem.setDone(button.selected))
                }
            }
            
        }
    }
    
}