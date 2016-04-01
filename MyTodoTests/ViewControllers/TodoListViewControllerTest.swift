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

class TodoListViewControllerTest: BaseTestCase {

    let todoListServiceStub = TodoListServiceStub()


    func getTodoListViewController() -> TodoListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let initialViewController = storyboard.instantiateInitialViewController() as? UINavigationController {
            if let todoListViewController = initialViewController.topViewController as? TodoListViewController {
                todoListViewController.todoItemService = todoListServiceStub
                return todoListViewController
            }
        }
		
        XCTFail("Could not load TodoListViewController")
        return TodoListViewController()
	}
	
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
        withTableView() { tableView in assertThat(tableView.delegate, present()) }
    }
    
    
    
    func testTableViewHasMultiplesRows() {

        var todoItems = [TodoItem]()

        for arrayLength in 0...3 {
            todoListServiceStub.reset()
            let todoListViewController = presentTodoListViewController(todoItems)
            assertThat(todoListViewController.tableView(todoListViewController.tableView!, numberOfRowsInSection: 0), equalTo(arrayLength))
            todoItems.append(TodoItem(title: "foobar"))
        }
    }
    
    func testTableViewShowsAllTodoItems() {
        let todoItems = [
               TodoItem(title: "1"),
               TodoItem(title: "2"),
               TodoItem(title: "3")
        ]
        let todoListViewController = presentTodoListViewController(todoItems)

        todoListViewController.todoItemService.withTodoItems() {
            todoItems in
            for (index, item) in todoItems.enumerate() {
                if let tableCell = todoListViewController.tableView(todoListViewController.tableView!, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0)) as? TodoItemCell {
                    assertThat(tableCell.titleLabel, present())

                    assertThat(tableCell.titleLabel?.text, presentAnd(equalTo(item.title)))
                } else {
                    XCTFail("cell empty")
                }
            }
        }

    }
    
    func presentTodoListViewController(todoItems:[TodoItem] = []) -> TodoListViewController {
        let todoListViewController = getTodoListViewController()
        for item in todoItems {
            todoListViewController.todoItemService.addTodoItem(item)
        }
        let testNavigationController = TestNavigationController(rootViewController: todoListViewController)
        presentViewController(testNavigationController)
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
        let todoListViewController = getTodoListViewController()
        let navigationController = UINavigationController(rootViewController: todoListViewController)
        presentViewController(navigationController, useWindow: true)

        if let tableView = todoListViewController.tableView {
            assertThat(tableView.frame.origin.x, equalTo(0))
            assertThat(tableView.frame.origin.y, equalTo(0))
            assertThat(tableView.frame.size.width, equalTo(todoListViewController.view.frame.size.width))
            assertThat(tableView.frame.size.height, equalTo(todoListViewController.view.frame.size.height))
        }
    }

    func testTableViewLayoutWithConstraints() {
        let todoListViewController = getTodoListViewController()
        presentViewController(todoListViewController)

        if let tableView = todoListViewController.tableView {
            assertThat(tableView, isPinned(.Leading))
            assertThat(tableView, isPinned(.Trailing))
            assertThat(tableView, isPinned(.Top))
            assertThat(tableView, isPinned(.Bottom, to: todoListViewController.bottomLayoutGuide))
        }
    }


    func testHasCorrectTitle() {
        let todoListViewController = presentTodoListViewController()
        
        assertThat(todoListViewController.navigationItem.title, presentAnd(equalTo("My Todo List")))
    }

    func testHasAddTodoButton() {
        let todoListViewController = presentTodoListViewController()
        
        let rightItem = todoListViewController.navigationItem.rightBarButtonItem
        assertThat(rightItem, present())
        assertThat(rightItem?.valueForKey("systemItem") as? Int, presentAnd(equalTo(UIBarButtonSystemItem.Add.rawValue)))
    }
    
    func testWhenPressingAddButtonAddViewIsShown() {
        let todoListViewController = presentTodoListViewController()
        
        let addButton = todoListViewController.navigationItem.rightBarButtonItem
        assertThat(addButton, present())
        assertThat(addButton?.action, present())
        
        addButton?.performAction()

        assertThat(todoListViewController.navigationController?.topViewController, presentAnd(instanceOf(AddTodoItemViewController)))
    }

    func testWhenPressingAddButtonAddViewIsShown_AndClosureIsSet() {
         let todoListViewController = presentTodoListViewController()

         let addButton = todoListViewController.navigationItem.rightBarButtonItem
         assertThat(addButton, present())
         assertThat(addButton?.action, present())

         addButton?.performAction()


         let addTodoItemViewController = todoListViewController.navigationController?.topViewController as? AddTodoItemViewController
         assertThat(addTodoItemViewController, presentAnd(instanceOf(AddTodoItemViewController)))

         assertThat(addTodoItemViewController?.addTodoItem, present())
     }

    func testTableGetsReloadedOnViewWillAppear() {
        todoListServiceStub.automaticCompletion = false
        let todoListViewController = presentTodoListViewController()

        let tableView = UITableViewStub()
        todoListViewController.tableView = tableView

        todoListServiceStub.callLastCompletion()

        assertThat(tableView.hasReloadData == true)
    }
    
    func testWhenSelectingTodoItem_EditViewIsShown() {
        let todoItems = [TodoItem(title: "Buy Milk")]
        let todoListViewController = presentTodoListViewController(todoItems)

        
        if let tableView = todoListViewController.tableView {
            todoListViewController.tableView(tableView, didSelectRowAtIndexPath:NSIndexPath(forRow: 0, inSection: 0))
            assertThat(todoListViewController.navigationController?.topViewController, presentAnd(instanceOf(EditTodoItemViewController)))
        } else {
            XCTFail("tableView is empty")
        }
    }
    
    func testWhenSelectingTodoItem_EditViewIsShown_AndTodoItemIsSet() {
        let todoListViewController = presentTodoListViewController()
        
        if let tableView = todoListViewController.tableView {
            todoListViewController.tableView(tableView, didSelectRowAtIndexPath:NSIndexPath(forRow: 0, inSection: 0))
            if let editTodoItemViewController = todoListViewController.navigationController?.topViewController as? EditTodoItemViewController {
                    assertThat(editTodoItemViewController.todoItem, present())
            }
            
        } else {
            XCTFail("tableView is empty")
        }
    }
    
    
    func testWhenSelectingTodoItem_EditViewIsShown_AndClosureIsSet() {
        let todoItems = [TodoItem(title: "Buy Milk")]
        let todoListViewController = presentTodoListViewController(todoItems)

        if let tableView = todoListViewController.tableView {
            todoListViewController.tableView(tableView, didSelectRowAtIndexPath:NSIndexPath(forRow: 0, inSection: 0))
            let editTodoItemViewController = todoListViewController.navigationController?.topViewController as? EditTodoItemViewController
            assertThat(editTodoItemViewController?.saveTodoItem, present())
        } else {
            XCTFail("tableView is empty")
        }
        
    }
    
    func testTableCellIsProperClass() {
        let todoItems = [TodoItem(title: "Buy Milk")]
        let todoListViewController = presentTodoListViewController(todoItems)

        todoListViewController.todoItemService.withTodoItems() {
            todoItems in
            for (index, _) in todoItems.enumerate() {
                let tableCell = todoListViewController.tableView(todoListViewController.tableView!, cellForRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0))
                assertThat(tableCell, instanceOf(TodoItemCell))
            }
        }
    }
    
    func testTableCellCanBeEdited() {
        let todoItems = [TodoItem(title: "Buy Milk")]
        let todoListViewController = presentTodoListViewController(todoItems)

        todoListViewController.todoItemService.withTodoItems() {
            todoItems in
            for (index, _) in todoItems.enumerate() {
                let editable = todoListViewController.tableView(todoListViewController.tableView!, canEditRowAtIndexPath: NSIndexPath(forRow: index, inSection: 0))
                assertThat(editable == true)
            }
        }
        
        assertThat(todoListViewController.tableView?.allowsSelectionDuringEditing, presentAnd(equalTo(true)))
        assertThat(todoListViewController.tableView?.allowsMultipleSelectionDuringEditing, presentAnd(equalTo(false)))
    }
    
    func testDeleteTodoItem() {
        let todoItems = [TodoItem(title: "Buy Milk")]
        let todoListViewController = presentTodoListViewController(todoItems)

        let tableViewStub = UITableViewStub()
        todoListViewController.tableView = tableViewStub

        todoListViewController.todoItemService.withTodoItems() {
            todoItems in
            assertThat(todoItems, hasCount(1))
        }

        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        todoListViewController.tableView(todoListViewController.tableView!, commitEditingStyle:.Delete, forRowAtIndexPath:indexPath)
        todoListViewController.todoItemService.withTodoItems() {
            todoItems in
            assertThat(todoItems, hasCount(0))
        }
        
        assertThat(tableViewStub.deleteRowsAtIndexPaths, hasCount(1))
        assertThat(tableViewStub.deleteRowsAtIndexPaths, hasItem(indexPath))
    }
    
    

}
