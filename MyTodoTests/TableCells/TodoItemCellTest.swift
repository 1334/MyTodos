//
//  TodoItemCellTest.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import Hamcrest
@testable import MyTodo

class TodoItemCellTest : BaseTestCase {
    
   
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
    
    func presentTodoListViewController() -> TodoListViewController {
        let todoListViewController = getTodoListViewController()
        todoListViewController.todoItemService = InMemoryTodoItemService()
        todoListViewController.todoItemService.addTodoItem(TodoItem(title: "Buy milk"))

        presentViewController(todoListViewController)
        return todoListViewController
    }

    
    typealias TodoItemCellAssertClosure = (cell: TodoItemCell) -> Void

    func withCell(asserts : TodoItemCellAssertClosure) -> TodoListViewController {
        let todoListViewController = presentTodoListViewController()
        
        let cell = todoListViewController.tableView(todoListViewController.tableView!, cellForRowAtIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        if let todoItemCell = cell as? TodoItemCell {
            asserts(cell: todoItemCell)
        } else {
          XCTFail("cell is not a TodoItemCell: \(cell)")
        }
        return todoListViewController
    }
    
    func testTableCellIsPresent() {
        withCell() { cell in
            assertThat(cell, present())
        }
    }
    
    func testCellsTextView() {
        withCell() { cell in
            assertThat(cell.titleLabel?.text, presentAnd(equalTo("Buy milk")))
        }
    }
    
    func testCellsDoneButton() {
        withCell() { cell in
            assertThat(cell.doneButton, presentAnd(instanceOf(UIButton)))
        }
    }
    
    func testCellsDoneButtonHasProperLayout() {
        withCell() { cell in
            assertThat(cell.doneButton, presentAnd(isPinned(.Leading)))
            assertThat(cell.doneButton, presentAnd(isPinned(.Top)))
            assertThat(cell.doneButton, presentAnd(isPinned(.Bottom)))
            assertThat(cell.doneButton, presentAnd(hasWidthOf(44)))
        }
    }
    
    func testCellsTextLabelProperLayout() {
        withCell() { cell in
            assertThat(cell.titleLabel, presentAnd(isPinned(.Leading, toView: cell.doneButton)))
            assertThat(cell.titleLabel, presentAnd(isVerticalCenter()))
        }
    }

    func testCellDoneButtonCheckMark() {
        withCell() { cell in
            if let button = cell.doneButton {
                assertThat(button.backgroundImageForState(.Normal), presentAnd(equalToImage(StyleKit.imageOfCheck(done: false))))
                assertThat(button.backgroundImageForState(.Selected), presentAnd(equalToImage(StyleKit.imageOfCheck(done: true))))
            } else {
                XCTFail("button not found")
            }
            assertThat(cell.doneButton, presentAnd(instanceOf(UIButton)))

        }
    }
    
    typealias UIButtonAssertClosure = (button: UIButton) -> Void
    
    func withButton(asserts : UIButtonAssertClosure) {
        withCell() { cell in
            if let button = cell.doneButton {
                asserts(button: button)
            } else {
                XCTFail("button is empty")
            }
        }
    }

    
    func testCellDoneButtonShouldHaveNotText() {
        withButton() { button in
         
            let isEmpty = anyOf(
                not(present()),
                presentAnd(equalTo(""))
            )
         
            assertThat(button.titleForState(.Normal), isEmpty)
            assertThat(button.titleForState(.Selected), isEmpty)
            assertThat(button.titleForState(.Highlighted), isEmpty)
        }
    }
    
    func testCellDoneButtonTypeShouldBeCustom() {
        // this is needed, otherwise there is an additional background image when the button is selected
        withButton() { button in
            assertThat(button.buttonType, equalTo(.Custom))
        }
    }
    
    func testCellDoneButtonShouldShowCheckmarkWhenPressed() {
        withButton() { button in
            assertThat(button.selected, equalTo(false))
            button.performAction()
            assertThat(button.selected, equalTo(true))
            button.performAction()
            assertThat(button.selected, equalTo(false))
        }
    }
    
    func testTodoItemIsSet() {
        withCell() { cell in
            let todoItem = TodoItem(identifier: 1, title: "Buy Beer", done: true)
            cell.todoItem = todoItem
            assertThat(cell.titleLabel?.text, presentAnd(equalTo("Buy Beer")))
            assertThat(cell.doneButton?.selected, presentAnd(equalTo(true)))
        }
    }

    
    func testCellDoneButtonPressedAndTodoItemsChanges() {
        
        var closureExecuted = false
        withCell() { cell in
            cell.todoItemChangeClosure = {
                old, new in
                closureExecuted = true
                
                assertThat(old.done == false)
                assertThat(new.done == true)
            }

            if let button = cell.doneButton {
                button.performAction()
            }
        }
        
        assertThat(closureExecuted, equalTo(true))
    }
    
    
    func testCellItemChangeClosureIsSet() {
        withCell() { cell in
            assertThat(cell.todoItemChangeClosure, present())
        }
    }
    
    func testCellItemChangeClosureExecutionStoredTheTodoItem() {
        let viewController = withCell() { cell in
            cell.doneButton?.performAction()
        }
        
        assertThat(viewController.todoItemService.todoItems, hasCount(1))
        assertThat(viewController.todoItemService.todoItems[0].done, equalTo(true))
    }


}
