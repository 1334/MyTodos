//
//  TodoItemViewController.swift
//  MyTodo
//
//  Created by Rene Pirringer on 30.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

class TodoItemViewController: UIViewController {
    var todoItemClosure: TodoItemClosure?
    
    @IBOutlet weak var titleField: UITextField?
    
    @IBAction func rightBarButtonPressed() {
        if let todoItem = createTodoItem() {
            todoItemClosure?(todoItem) {
                [unowned self] result, error in // TODO: pop the view controller here!
                if result != nil {
                    self.navigationController?.popViewControllerAnimated(true)
                } else {
                    // TODO: Error handling
                }
            }
        }

    }
    
    func createTodoItem() -> TodoItem? {
        if let text = titleField?.text {
            return TodoItem(title:text)
        }
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField?.placeholder = "Title"
        titleField?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        checkEnableRightBarButton()
    }
    
    
    @IBAction func checkEnableRightBarButton() {
        if let rightButton = navigationItem.rightBarButtonItem {
            rightButton.enabled = titleField?.text?.characters.count > 0
        }
    }
}
