//
//  UserDefaultsTodoItemService.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import Hamcrest
@testable import MyTodo

class UserDefaultsTodoItemServiceTest : XCTestCase {
    
    let todoItemService = UserDefaultsTodoItemService()
    let userDefaults = NSUserDefaults.standardUserDefaults()

    override func tearDown() {
        super.tearDown()
        userDefaults.removeObjectForKey("MyTodos")
    }
    
    func userDefaultsArray() -> [AnyObject] {
        if let result = userDefaults.arrayForKey("MyTodos") {
            return result
        }
        return []
    }
    
    func testAddTodoItem() {
        let todoItem = TodoItem(title: "Buy milk")
        let addedTodoItem = todoItemService.addTodoItem(todoItem)
        
        assertThat(addedTodoItem, not(equalTo(todoItem)))
        assertThat(addedTodoItem.title, equalTo(todoItem.title))
        assertThat(addedTodoItem.identifier, not(equalTo(TodoItem.newItemIdentifer)))
        
        
        assertThat(userDefaultsArray(), hasCount(1))
        
        let item = 
        assertThat(userDefaultsArray()[0], equalTo(addedTodoItem.asDictionary()))
        
    }
}