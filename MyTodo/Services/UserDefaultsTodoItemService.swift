//
//  UserDefaultsTodoItemService.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation

class UserDefaultsTodoItemService : InMemoryTodoItemService {
 
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func addTodoItem(item: TodoItem) -> TodoItem {
        let result = super.addTodoItem(item)
        save()
        return result
    }
    
    /*
    override func saveTodoItem(item: TodoItem) -> TodoItem {
        save()
    }
    
    override func removeItem(item: TodoItem) -> TodoItem? {
        save()
    }
 */
    
    func save() {
        var dataArray = [AnyObject]()
        for item in self.todoItems {
            dataArray.append(item.asDictionary())
        }
        userDefaults.setObject(dataArray, forKey: "MyTodos")
    }
    
    
    
}