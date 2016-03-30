//
//  TodoListViewController.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import UIKit

class TodoListViewController: UIViewController, UITableViewDataSource {
    @IBOutlet var tableView:UITableView?
    let tableViewDelegate:UITableViewDelegate = MyTodoTableViewDelegate()
    let cellIdentifier = "todoListCellItem"

    var todoItemService = TodoItemService()


    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.delegate = tableViewDelegate
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView?.reloadData()
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItemService.todoItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableCell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        tableCell.textLabel?.text = todoItemService.todoItems[indexPath.row].title
        return tableCell
    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let addTodoViewController = segue.destinationViewController as? AddTodoItemViewController {
            addTodoViewController.addTodoItem = todoItemService.addTodoItem
        }
    }


}
