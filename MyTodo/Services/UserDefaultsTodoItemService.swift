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
    

    
    override init() {
        super.init()
        if let array = userDefaults.arrayForKey("MyTodos") {
            for item in array {
                if let dictionary = item as? [String:AnyObject] {
                    if let item = TodoItem(dictionary: dictionary) {
                        super.appendItem(item)
                    }
                }
            }
        }
    }
    
    override func addTodoItem(item: TodoItem) -> TodoItem {
        let result = super.addTodoItem(item)
        save()
        return result
    }
    override func saveTodoItem(item: TodoItem) -> TodoItem {
        let result = super.saveTodoItem(item)
        save()
        return result
    }
    
    
    override func removeItem(item: TodoItem) -> TodoItem? {
        let result = super.removeItem(item)
        save()
        return result
    }
    
    func save() {
        var dataArray = [AnyObject]()
        for item in self.todoItems {
            dataArray.append(item.asDictionary())
        }
        userDefaults.setObject(dataArray, forKey: "MyTodos")
    }
    
    
    
    
}