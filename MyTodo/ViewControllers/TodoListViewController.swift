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

    var todoItemService = TodoItemService()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = self
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItemService.todoItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if let tableCell = tableView.dequeueReusableCellWithIdentifier(TodoListViewController.cellIdentifier) as? TodoItemCell {
            tableCell.todoItem = todoItemService.todoItems[indexPath.row]
            tableCell.todoItemChangeClosure = {
                [unowned self] (old, new) in
                self.todoItemService.saveTodoItem(new)
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
        let todoItem = todoItemService.todoItems[indexPath.row]
        self.performSegueWithIdentifier(TodoListViewController.editTodoItemIdentifier, sender: todoItem)
    }

}
