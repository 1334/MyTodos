//
//  TodoItemService.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation

class InMemoryTodoItemService: NSObject, TodoItemService {
    
    static let NotFound = -1

    private(set) var todoItems = [TodoItem]()
    
    static var identifier = 0

    func todoItems(result: TodoItemListResultClosure) {
        result(todoItems, nil)
    }

    func addTodoItem(item: TodoItem, result: TodoItemResultClosure) {
        InMemoryTodoItemService.identifier = InMemoryTodoItemService.identifier + 1
        let addedTodoItem = TodoItem(identifier:InMemoryTodoItemService.identifier, title:item.title, done:item.done)
        self.todoItems.append(addedTodoItem)
        result(addedTodoItem, nil)
    }
    
    func saveTodoItem(item: TodoItem, result: TodoItemResultClosure) {
        let index = indexOfTodoItem(item)
        if (index != InMemoryTodoItemService.NotFound) {
            todoItems[index] = item
        }
        result(item, nil)
    }
    
    func removeTodoItem(item: TodoItem, result: TodoItemResultClosure) {
        let index = indexOfTodoItem(item)
        if (index != InMemoryTodoItemService.NotFound) {
            result(todoItems.removeAtIndex(index), nil)
        }
        result(nil, NSError(domain:"MyTodos", code:1, userInfo: nil))
    }
    
    private func indexOfTodoItem(item: TodoItem) -> Int {
        for (index, element) in todoItems.enumerate() {
            if (element.identifier == item.identifier) {
                return index
            }
        }
        return InMemoryTodoItemService.NotFound
    }

    /* protected */ func appendItem(item: TodoItem) {
        todoItems.append(item)
    }
    
    
}
