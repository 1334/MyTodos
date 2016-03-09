//
//  TodoListViewControllerTest.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import XCTest
import Hamcrest
@testable import MyTodo

class TodoListViewControllerTest: XCTestCase {

    func testHasATableView() {
        let todoListViewController = presentTodoListViewController()

        assertThat(todoListViewController.tableView, present())
    }
    
    func testTableViewHasADataSource() {
        let todoListViewController = presentTodoListViewController()
        
        if let tableView = todoListViewController.tableView {
            assertThat(tableView.dataSource, present())
        }
    }
    
    func testTableViewHasADelegate() {
        withTableView() { tableView in assertThat(tableView.delegate, present()) }
    }

    func testTableViewHasOneSection() {
        let todoListViewController = presentTodoListViewController()
        todoListViewController.todoItems = []
        
        for arrayLength in 0...3 {
            assertThat(todoListViewController.tableView(todoListViewController.tableView!, numberOfRowsInSection: 0), equalTo(arrayLength))
            todoListViewController.todoItems.append("foobar")
        }
    }
    
    func testTableViewShowsAllTodoItems() {
        let todoListViewController = presentTodoListViewController()
        todoListViewController.todoItems = [ "1", "2", "3" ]
        
        for (index, item) in todoListViewController.todoItems.enumerate() {
            let tableCell = todoListViewController.tableView(todoListViewController.tableView!, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0))
            assertThat(tableCell.textLabel, present())

            assertThat(tableCell.textLabel?.text, presentAnd(equalTo(item)))
        }

    }
    
    func presentTodoListViewController() -> TodoListViewController {
        let todoListViewController = getTodoListViewController()
        presentViewController(todoListViewController)
        return todoListViewController
    }
    
    typealias TableViewAssertClosure = (tableView: UITableView) -> Void
    
    func withTableView(asserts : TableViewAssertClosure) {
        let todoListViewController = presentTodoListViewController()
        
        if let tableView = todoListViewController.tableView {
            asserts(tableView: tableView)
        }
    }
    
    func testTableViewFillsSuperView() {
        let todoListViewController = presentTodoListViewController()
        
        if let tableView = todoListViewController.tableView {
            assertThat(tableView.frame.origin.x, equalTo(0))
            assertThat(tableView.frame.origin.y, equalTo(0))
            assertThat(tableView.frame.size.width, equalTo(todoListViewController.view.frame.size.width))
            assertThat(tableView.frame.size.height, equalTo(todoListViewController.view.frame.size.height))
        }
    }
    
    func testHasCorrectTitle() {
        let todoListViewController = presentTodoListViewController()
        
        assertThat(todoListViewController.navigationItem.title, presentAnd(equalTo("My Todo List")))
    }
    
    func getTodoListViewController() -> TodoListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() as? UINavigationController {
            if let todoListViewController = initialViewController.topViewController as? TodoListViewController {
                return todoListViewController
            }
        }
        
        XCTFail("Could not load TodoListViewController")
        return TodoListViewController()
    }

}
