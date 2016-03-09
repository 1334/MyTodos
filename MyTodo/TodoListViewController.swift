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
    var todoItems : [String] = ["Buy Milk", "Buy Beer", "Drink Beer", "World Domination"]
    let cellIdentifier = "todoListCellItem"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView?.delegate = tableViewDelegate
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let tableCell = UITableViewCell(style: .Default, reuseIdentifier: cellIdentifier)
        tableCell.textLabel?.text = todoItems[indexPath.row]

        return tableCell
    }

}
