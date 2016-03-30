//
//  AddTodoItemViewController.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import UIKit

class AddTodoItemViewController: TodoItemViewController {
    
    var addTodoItem: AddTodoItemClosure? {
        set(addTodoItemClosure) {
            super.todoItemClosure = addTodoItemClosure
        }
        
        get {
            return super.todoItemClosure
        }
    }

    
}
