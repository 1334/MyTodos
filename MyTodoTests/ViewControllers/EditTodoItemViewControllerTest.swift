//
//  EditTodoItemViewControllerTest.swift
//  MyTodo
//
//  Created by Rene Pirringer on 30.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import Hamcrest
@testable import MyTodo


class EditTodoItemViewControllerTest : BaseTestCase {

    let todoListServiceStub = TodoListServiceStub()

    func getEditTodoItemViewController() -> EditTodoItemViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewControllerWithIdentifier("EditTodoItemViewController") as? EditTodoItemViewController {
            viewController.todoItemClosure = todoListServiceStub.saveTodoItem
            return viewController
        }
        
        XCTFail("Could not load EditTodoItemViewController")
        return EditTodoItemViewController()
    }
    
    func presentEditTodoItemViewController(todoItem: TodoItem? = nil) -> EditTodoItemViewController {
        let viewController = getEditTodoItemViewController()
        viewController.todoItem = todoItem
        let testNavigationController = TestNavigationController(rootViewController: viewController)
        presentViewController(testNavigationController)
        return viewController
    }
    
    
    func testHasCorrectTitle() {
        let viewController = presentEditTodoItemViewController()
        assertThat(viewController.navigationItem.title, presentAnd(equalTo("Edit Todo")))
    }
    
    
    func testHasTextField() {
        let viewController = presentEditTodoItemViewController()
        assertThat(viewController.titleField, presentAnd(instanceOf(UITextField)))
    }


    func withTitleField(asserts : (titleField: UITextField) -> Void) {
        let todoListViewController = presentEditTodoItemViewController()
        if let titleField = todoListViewController.titleField {
            asserts(titleField: titleField)
        }
    }
    
    func testTextFieldHasNoBorder() {
        withTitleField() { textField in
            assertThat(textField.borderStyle, equalTo(UITextBorderStyle.None))
        }
    }

    
    
    func testTextFieldHasLayout() {
        let viewController = presentEditTodoItemViewController()
        if let titleField = viewController.titleField {
            assertThat(titleField, isPinned(.Leading, gap:20))
            assertThat(titleField, isPinned(.Trailing, gap:20))
            assertThat(titleField, isPinned(.Top, to:viewController.topLayoutGuide, gap:20))
        }
    }
    func testTextFieldHasPlaceholder() {
        withTitleField() { textField in
            assertThat(textField.placeholder, presentAnd(equalTo("Title")))
        }
    }
    
    func testTextFieldTitleTextSetText() {
        let viewController = presentEditTodoItemViewController(TodoItem(title: "Buy milk"))
        if let titleField = viewController.titleField {
            assertThat(titleField.text, presentAnd(equalTo("Buy milk")))
        }
    }

    func testTextFieldHasBodyFont() {
        withTitleField() { textField in
            let headlineFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
            assertThat(textField.font, presentAnd(equalTo(headlineFont)))
        }
    }
    
    func testHasSaveButton() {
        let viewController = presentEditTodoItemViewController(TodoItem(title: "Buy milk"))
        
        let rightItem = viewController.navigationItem.rightBarButtonItem
        assertThat(rightItem, present())
        assertThat(rightItem?.valueForKey("systemItem") as? Int, presentAnd(equalTo(UIBarButtonSystemItem.Save.rawValue)))
        assertThat(rightItem?.enabled, presentAnd(equalTo(true)))
    }

    func testEnterTextEnabledDoneButton() {
        
        let viewController = presentEditTodoItemViewController(TodoItem(title: "Buy milk"))
        
        if let titleField = viewController.titleField {
            for _ in 0...7 {
                titleField.backspace()
            }
            
            let rightItem = viewController.navigationItem.rightBarButtonItem
            assertThat(rightItem?.enabled, presentAnd(equalTo(false)))
            
        } else {
            XCTFail("titleField is empty")
        }
    }
    

    
    func testWhenPressingSaveButton_EditView_IsDismissed() {
        let viewController = getEditTodoItemViewController()
        viewController.todoItem = TodoItem(title: "Buy milk")
        let rootViewController = UIViewController()
        let testNavigationController = TestNavigationController(rootViewController: rootViewController)
        
        presentViewController(testNavigationController)
        testNavigationController.pushViewController(viewController, animated: false)
        
        let saveButton = viewController.navigationItem.rightBarButtonItem
        assertThat(saveButton, present())
        assertThat(saveButton?.action, present())

        viewController.titleField?.type("T")
        saveButton?.performAction()
        
        assertThat(testNavigationController.topViewController, presentAnd(equalTo(rootViewController)))
    }
    

    
    func testWhenPressingDoneButton_TodoItem_isChanged() {
        let todoItem = TodoItem(identifier: 1, title: "Buy milk")
        let viewController = presentEditTodoItemViewController(todoItem)
        
        
        var closureExecuted = false
        viewController.todoItemClosure = { todoItem, resultClosure in
            closureExecuted = true
            assertThat(todoItem.identifier, equalTo(1))
            assertThat(todoItem.title, equalTo("Buy milk"))
        }
        
        let addButton = viewController.navigationItem.rightBarButtonItem
        addButton?.performAction()
        
        assertThat(closureExecuted == true)
    }
}