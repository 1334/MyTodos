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
    static let cellIdentifier = "todoListCellItem"
    
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
        let tableCell = UITableViewCell(style: .Default, reuseIdentifier: TodoListViewController.cellIdentifier)
        tableCell.textLabel?.text = todoItemService.todoItems[indexPath.row].title
        return tableCell
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
