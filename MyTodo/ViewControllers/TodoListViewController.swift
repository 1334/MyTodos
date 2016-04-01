//
//  TodoListViewController.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    static let editTodoItemIdentifier = "EditTodoItem"
    static let cellIdentifier = "TodoItemCell"
    
    @IBOutlet var tableView:UITableView?

    var todoItemService:TodoItemService = UserDefaultsTodoItemService()

    private var todoItems = [TodoItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadItems()
        tableView?.reloadData()
    }

    func loadItems() {
        todoItemService.todoItems() {
            [unowned self] result, error in
            if let todoItems = result {
                self.todoItems = todoItems
            }

        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todoItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let tableCell = tableView.dequeueReusableCellWithIdentifier(TodoListViewController.cellIdentifier) as? TodoItemCell {
            tableCell.todoItem = self.todoItems[indexPath.row]
            tableCell.todoItemChangeClosure = {
                [unowned self] (old, new) in
                self.todoItemService.saveTodoItem(new, result:{a,b in})
            }
            return tableCell
        }
        // make the compiler happy, this line of code should be never reached
        return TodoItemCell(style: .Default, reuseIdentifier: TodoListViewController.cellIdentifier)
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let addTodoViewController = segue.destinationViewController as? AddTodoItemViewController {
            addTodoViewController.addTodoItem = todoItemService.addTodoItem
        }
        
        if let editTodoItemViewController = segue.destinationViewController as? EditTodoItemViewController {
            if let todoItem = sender as? TodoItem {
                editTodoItemViewController.todoItem = todoItem
                editTodoItemViewController.saveTodoItem = todoItemService.saveTodoItem
            }
        }
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let todoItem = todoItemAtIndex(indexPath.row) {
            self.performSegueWithIdentifier(TodoListViewController.editTodoItemIdentifier, sender: todoItem)
        }
    }

    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if let todoItem = todoItemAtIndex(indexPath.row) {
            todoItemService.removeTodoItem(todoItem) {
                result, error in
                // TODO: in case of an error, show the error to the user and insert the (not) deleted item
            }
            todoItems.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
    
    func todoItemAtIndex(index: Int) -> TodoItem? {
        if todoItems.count > index {
            return todoItems[index]
        }
        return nil
    }
}
