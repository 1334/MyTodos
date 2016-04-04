//
// Created by Rene Pirringer on 29.03.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit
import XCTest
import Hamcrest
@testable import MyTodo

class AddTodoItemViewControllerTest : BaseTestCase {

    let todoListServiceStub = TodoListServiceStub()

    func getAddTodoItemViewController() -> AddTodoItemViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewControllerWithIdentifier("AddTodoItemViewController") as? AddTodoItemViewController {
            viewController.todoItemClosure = todoListServiceStub.addTodoItem
            return viewController
        }

        XCTFail("Could not load AddTodoItemViewController")
        return AddTodoItemViewController()
    }

    func presentAddTodoItemViewController() -> AddTodoItemViewController {
        let addTodoItemViewController = getAddTodoItemViewController()
        let testNavigationController = TestNavigationController(rootViewController: addTodoItemViewController)
        presentViewController(testNavigationController)
        return addTodoItemViewController
    }



    func testHasCorrectTitle() {
        let todoListViewController = presentAddTodoItemViewController()

        assertThat(todoListViewController.navigationItem.title, presentAnd(equalTo("Add Todo")))
    }


    func testHasTextField() {
        let todoListViewController = presentAddTodoItemViewController()
        assertThat(todoListViewController.titleField, presentAnd(instanceOf(UITextField)))
    }

    func withTitleField(asserts : (titleField: UITextField) -> Void) {
        let todoListViewController = presentAddTodoItemViewController()
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
        let todoListViewController = presentAddTodoItemViewController()
        if let titleField = todoListViewController.titleField {
            assertThat(titleField, isPinned(.Leading, gap:20))
            assertThat(titleField, isPinned(.Trailing, gap:20))
            assertThat(titleField, isPinned(.Top, to:todoListViewController.topLayoutGuide, gap:20))
        }
    }

    func testTextFieldHasPlaceholder() {
        withTitleField() { textField in
            assertThat(textField.placeholder, presentAnd(equalTo("Title")))
        }
    }

    func testTextFieldHasEmptyText() {
        withTitleField() { textField in
            assertThat(textField.text, presentAnd(equalTo("")))
        }
    }

    func testTextFieldHasBodyFont() {
        withTitleField() { textField in
            let headlineFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
            assertThat(textField.font, presentAnd(equalTo(headlineFont)))
        }
    }


    func testHasDoneButton() {
        let addTodoItemViewController = presentAddTodoItemViewController()

        let rightItem = addTodoItemViewController.navigationItem.rightBarButtonItem
        assertThat(rightItem, present())
        assertThat(rightItem?.valueForKey("systemItem") as? Int, presentAnd(equalTo(UIBarButtonSystemItem.Done.rawValue)))
        assertThat(rightItem?.enabled, presentAnd(equalTo(false)))
    }

    func testEnterTextEnabledDoneButton() {
        let addTodoItemViewController = presentAddTodoItemViewController()
        if let titleField = addTodoItemViewController.titleField {
            titleField.type("T")

            let rightItem = addTodoItemViewController.navigationItem.rightBarButtonItem
            assertThat(rightItem, present())
            assertThat(rightItem?.enabled, presentAnd(equalTo(true)))


        } else {
            XCTFail("titleField is empty")
        }
    }

    func pressDoneButton(viewController: AddTodoItemViewController) {
        let addButton = viewController.navigationItem.rightBarButtonItem
        assertThat(addButton, present())
        assertThat(addButton?.action, present())
        addButton?.performAction()
    }

    func testWhenPressingDoneButton_AddView_IsDismissed() {
        let addTodoItemViewController = getAddTodoItemViewController()
        todoListServiceStub.automaticCompletion = false

        let rootViewController = UIViewController()
        let testNavigationController = TestNavigationController(rootViewController: rootViewController)

        presentViewController(testNavigationController)
        testNavigationController.pushViewController(addTodoItemViewController, animated: false)

        addTodoItemViewController.titleField?.type("T")
        pressDoneButton(addTodoItemViewController)

        assertThat(testNavigationController.topViewController, presentAnd(equalTo(addTodoItemViewController)))
        todoListServiceStub.callLastCompletion()
        assertThat(testNavigationController.topViewController, presentAnd(equalTo(rootViewController)))
    }

    func testWhenPressingDoneButton_TodoItem_isAdded() {
        let addTodoItemViewController = presentAddTodoItemViewController()

        var closureExecuted = false
        addTodoItemViewController.addTodoItem = { todoItem, result in
            closureExecuted = true
        }

        pressDoneButton(addTodoItemViewController)

        assertThat(closureExecuted == true)
    }


}
