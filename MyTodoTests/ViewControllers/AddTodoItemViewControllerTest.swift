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

    func getAddTodoItemViewController() -> AddTodoItemViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let addListViewController = storyboard.instantiateViewControllerWithIdentifier("AddTodoItemViewController") as? AddTodoItemViewController {
            return addListViewController
        }

        XCTFail("Could not load AddTodoItemViewController")
        return AddTodoItemViewController()
    }

    func presentAddTotoItemViewController() -> AddTodoItemViewController {
        let addTodoItemViewController = getAddTodoItemViewController()
        let testNavigationController = TestNavigationController(rootViewController: addTodoItemViewController)
        presentViewController(testNavigationController)
        return addTodoItemViewController
    }



    func testHasCorrectTitle() {
        let todoListViewController = presentAddTotoItemViewController()

        assertThat(todoListViewController.navigationItem.title, presentAnd(equalTo("Add Todo")))
    }


    func testHasTextField() {
        let todoListViewController = presentAddTotoItemViewController()
        assertThat(todoListViewController.titleField, presentAnd(instanceOf(UITextField)))
    }

    func withTitleField(asserts : (titleField: UITextField) -> Void) {
        let todoListViewController = presentAddTotoItemViewController()
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
        let todoListViewController = presentAddTotoItemViewController()
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
        let addTodoItemViewController = presentAddTotoItemViewController()

        let rightItem = addTodoItemViewController.navigationItem.rightBarButtonItem
        assertThat(rightItem, present())
        assertThat(rightItem?.valueForKey("systemItem") as? Int, presentAnd(equalTo(UIBarButtonSystemItem.Done.rawValue)))
        assertThat(rightItem?.enabled, presentAnd(equalTo(false)))
    }

    func testEnterTextEnabledDoneButton() {

        let addTodoItemViewController = presentAddTotoItemViewController()

        if let titleField = addTodoItemViewController.titleField {
            titleField.type("T")

            let rightItem = addTodoItemViewController.navigationItem.rightBarButtonItem
            assertThat(rightItem, present())
            assertThat(rightItem?.enabled, presentAnd(equalTo(true)))


        } else {
            XCTFail("titleField is empty")
        }

    }

    func testWhenPressingDoneButton_AddView_IsDismissed() {
        let addTodoItemViewController = getAddTodoItemViewController()
        let rootViewController = UIViewController()
        let testNavigationController = TestNavigationController(rootViewController: rootViewController)

        presentViewController(testNavigationController)
        testNavigationController.pushViewController(addTodoItemViewController, animated: false)

        let addButton = addTodoItemViewController.navigationItem.rightBarButtonItem
        assertThat(addButton, present())
        assertThat(addButton?.action, present())

        addButton?.performAction()

        assertThat(testNavigationController.topViewController, presentAnd(equalTo(rootViewController)))
    }

    func testWhenPressingDoneButton_TodoItem_isAdded() {
        let addTodoItemViewController = presentAddTotoItemViewController()

        var closureExecuted = false
        addTodoItemViewController.addTodoItem = { todoItem in
            closureExecuted = true
        }

        let addButton = addTodoItemViewController.navigationItem.rightBarButtonItem
        addButton?.performAction()

        assertThat(closureExecuted == true)
    }


}
