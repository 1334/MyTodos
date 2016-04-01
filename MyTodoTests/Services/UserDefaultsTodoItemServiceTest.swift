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
        
        if let dictionary = userDefaultsArray()[0] as? [String:AnyObject] {
            let item = TodoItem(dictionary: dictionary);
            assertThat(item, presentAnd(equalTo(addedTodoItem)))
        } else {
            XCTFail("loaded data is no dictionary")
        }
    }
    
    func testSaveTodoItem() {
        let todoItem = TodoItem(title: "Buy milk")
        let addedTodoItem = todoItemService.addTodoItem(todoItem)
        let savedTodoItem = todoItemService.saveTodoItem(addedTodoItem.setDone(true))
        
        assertThat(userDefaultsArray(), hasCount(1))
        
        if let dictionary = userDefaultsArray()[0] as? [String:AnyObject] {
            let item = TodoItem(dictionary: dictionary);
            assertThat(item, presentAnd(equalTo(savedTodoItem)))
        } else {
            XCTFail("loaded data is no dictionary")
        }
    }
    
    func testRemovedTodoItem() {
        let todoItem = TodoItem(title: "Buy milk")
        let addedTodoItem = todoItemService.addTodoItem(todoItem)
        
        assertThat(userDefaultsArray(), hasCount(1))
        todoItemService.removeItem(addedTodoItem)
        assertThat(userDefaultsArray(), hasCount(0))
    }
    
    func testLoadTodoItemsFromUserDefaults() {
        let todoItem = TodoItem(title: "Buy milk")

        userDefaults.setObject([todoItem.asDictionary()], forKey: "MyTodos")
        let itemService = UserDefaultsTodoItemService()

        assertThat(itemService.todoItems, hasCount(1))
        assertThat(itemService.todoItems, hasItem(todoItem))

    }
}