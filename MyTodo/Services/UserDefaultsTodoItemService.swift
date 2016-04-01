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

    func callAndSaveItem(item:TodoItem, result:TodoItemResultClosure, toCall: TodoItemClosure) {
        toCall(item) {
            [unowned self] item, error in
            self.save()
            result(item, error)
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
    
    func save() {
        var dataArray = [AnyObject]()
        for item in self.todoItems {
            dataArray.append(item.asDictionary())
        }
        userDefaults.setObject(dataArray, forKey: "MyTodos")
    }
    
    
    
    
}