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
        let todoListViewController = getTodoListViewController()
        presentViewController(todoListViewController)
        assertThat(todoListViewController.tableView, present())
    }
    
    func testTableViewHasADataSource() {
        let todoListViewController = getTodoListViewController()
        presentViewController(todoListViewController)
        
        if let tableView = todoListViewController.tableView {
            assertThat(tableView.dataSource, present())
        }
    }
    
    func testTableViewHasADelegate() {
        let todoListViewController = getTodoListViewController()
        presentViewController(todoListViewController)
        
        if let tableView = todoListViewController.tableView {
            assertThat(tableView.delegate, present())
        }
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
