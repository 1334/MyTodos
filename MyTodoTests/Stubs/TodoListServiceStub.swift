//
// Created by Rene Pirringer on 01.04.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

import Foundation
@testable import MyTodo


class TodoListServiceStub : InMemoryTodoItemService {

    var automaticCompletion = true
    var lastListCompletionClosure: TodoItemListResultClosure?
    var lastItemCompletionClosure: TodoItemResultClosure?
    var lastCompletionItemList: [TodoItem]?
    var lastCompletionItem: TodoItem?
    var lastCompletionError: NSError?

    func reset() {
        super.removeAll()
        automaticCompletion = true
    }

    func callLastCompletion() {

        if lastListCompletionClosure != nil {
            if let closure = lastListCompletionClosure {
                closure(lastCompletionItemList, lastCompletionError)
            }
        }

        if lastItemCompletionClosure != nil {
            if let closure = lastItemCompletionClosure {
                closure(lastCompletionItem, lastCompletionError)
            }
        }
    }


    func callAndSaveItem(item:TodoItem, result:TodoItemResultClosure, toCall: TodoItemClosure) {
        lastItemCompletionClosure = result
        toCall(item) {
            [unowned self] item, error in
            self.lastCompletionItem = item
            self.lastListCompletionClosure = nil
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

    override func todoItems(result: TodoItemListResultClosure) {
        lastListCompletionClosure = result
        super.todoItems() {
            [unowned self] items, error in
            self.lastCompletionItemList = items
            self.lastCompletionItem = nil
            self.lastCompletionError = error

            if self.automaticCompletion {
                self.callLastCompletion()
            }
        }

    }

}
