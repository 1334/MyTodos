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
}
