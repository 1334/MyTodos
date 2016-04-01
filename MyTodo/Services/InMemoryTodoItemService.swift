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

    
    func addTodoItem(item: TodoItem) -> TodoItem {
        InMemoryTodoItemService.identifier = InMemoryTodoItemService.identifier + 1
        let addedTodoItem = TodoItem(identifier:InMemoryTodoItemService.identifier, title:item.title, done:item.done)
        self.todoItems.append(addedTodoItem)
        return addedTodoItem
    }
    
    func saveTodoItem(item: TodoItem) -> TodoItem {
        let index = indexOfTodoItem(item)
        if (index != InMemoryTodoItemService.NotFound) {
            todoItems[index] = item
        }
        return item
    }
    
    func removeItem(item: TodoItem) -> TodoItem? {
        let index = indexOfTodoItem(item)
        if (index != InMemoryTodoItemService.NotFound) {
            return todoItems.removeAtIndex(index)
        }
        return nil
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
