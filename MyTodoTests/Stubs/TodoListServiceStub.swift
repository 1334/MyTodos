//
// Created by Rene Pirringer on 01.04.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

import Foundation
@testable import MyTodo


class TodoListServiceStub : InMemoryTodoItemService {

    var automaticCompletion = true
    var lastCompletionClosure: TodoItemListResultClosure?
    var lastCompletionItems: [TodoItem]?
    var lastCompletionError: NSError?

    func reset() {
        super.removeAll()
        automaticCompletion = true
    }

    func callLastCompletion() {
        if let closure = lastCompletionClosure {
            closure(lastCompletionItems, lastCompletionError)
        }
    }

/*
    func callAndSaveItem(item:TodoItem, result:TodoItemResultClosure, toCall: TodoItemClosure) {
        lastCompletionClosure = result
        toCall(item) {
            [unowned self] item, error in
            self.lastCompletionItem = item
            self.lastCompletionError = error
            if self.automaticCompletion {
                self.callLastCompletion()
            }
        }
    }

    override func addTodoItem(item: TodoItem, result: TodoItemResultClosure) {
        callAndSaveItem(item, result:result, toCall:super.addTodoItem)
    }

    override func saveTodoItem(item: TodoItem, result: TodoItemResultClosure) {
        callAndSaveItem(item, result:result, toCall:super.saveTodoItem)
    }

    override func removeTodoItem(item: TodoItem, result: TodoItemResultClosure) {
        callAndSaveItem(item, result:result, toCall:super.removeTodoItem)
    }
    */

    override func todoItems(result: TodoItemListResultClosure) {
        lastCompletionClosure = result
        super.todoItems() {
            [unowned self] items, error in
            self.lastCompletionItems = items
            self.lastCompletionError = error

            if self.automaticCompletion {
                self.callLastCompletion()
            }
        }

    }

}
