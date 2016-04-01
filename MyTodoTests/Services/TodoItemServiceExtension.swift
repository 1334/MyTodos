//
// Created by Rene Pirringer on 01.04.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import Hamcrest
@testable import MyTodo

extension TodoItemService {
    typealias TodoItemsAssertClosure = (todoItems: [TodoItem]) -> Void

    func withTodoItems(asserts: TodoItemsAssertClosure) {
        var closureExecuted = false
        self.todoItems() {
            result, error in
            if let todoItems = result {
                asserts(todoItems: todoItems)
            } else {
                XCTFail("todoItems empty")
            }
            closureExecuted = true
        }
        assertThat(closureExecuted == true)
    }

    func callWithResult(todoItem: TodoItem, toCall: TodoItemClosure) -> TodoItem {
        var result: TodoItem = ErrorTodoItem()
        toCall(todoItem) {
            todoItem, error in
            if let todoItemUnwrapped = todoItem {
                result = todoItemUnwrapped
            }
        }
        return result
    }

    func addTodoItem(todoItem: TodoItem) -> TodoItem {
        return callWithResult(todoItem, toCall: self.addTodoItem)
    }

    func saveTodoItem(todoItem: TodoItem) -> TodoItem {
        return callWithResult(todoItem, toCall: self.saveTodoItem)
    }

    func removeTodoItem(todoItem: TodoItem) -> TodoItem? {
        return callWithResult(todoItem, toCall: self.removeTodoItem)
    }



}