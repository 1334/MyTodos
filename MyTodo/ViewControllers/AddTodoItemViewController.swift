//
//  AddTodoItemViewController.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import UIKit

class AddTodoItemViewController: UIViewController {
    var addTodoItem: AddTodoItemClosure?
    
    @IBOutlet weak var titleField: UITextField?
    
    @IBAction func donePressed() {
        
        if let text = titleField?.text {
            addTodoItem?(TodoItem(title:text))
            
        }
        self.navigationController?.popViewControllerAnimated(true)
    
    }
}
