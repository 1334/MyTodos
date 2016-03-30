//
//  EditTodoItemViewController.swift
//  MyTodo
//
//  Created by Rene Pirringer on 30.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit


class EditTodoItemViewController : TodoItemViewController {
    
    var todoItem: TodoItem?
    
    override func viewWillAppear(animated: Bool) {
        self.titleField?.text = todoItem?.title
        super.viewWillAppear(animated)
    }
}
