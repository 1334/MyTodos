//
//  TodoItemServiceTest.swift
//  MyTodo
//
//  Created by Rene Pirringer on 30.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import Hamcrest
@testable import MyTodo

class TodoItemServiceTest : XCTestCase {
    
    let todoItemService = TodoItemService()
    
    
    func testAddTodoItem() {
        let todoItem = TodoItem(title: "Buy milk")
        let addedTodoItem = todoItemService.addTodoItem(todoItem)
        
        assertThat(addedTodoItem, not(equalTo(todoItem)))
        assertThat(addedTodoItem.title, equalTo(todoItem.title))
        assertThat(addedTodoItem.identifier, not(equalTo(TodoItem.newItemIdentifer)))
        
        assertThat(todoItemService.todoItems, hasItem(addedTodoItem))
        assertThat(todoItemService.todoItems, hasCount(5))
    }
    
    func testTodoItemHasChanged() {
        let todoItem = TodoItem(title: "Buy milk")
        let addedTodoItem = todoItemService.addTodoItem(todoItem)
        assertThat(todoItemService.todoItems, hasCount(5))

        let editedTodoItem = addedTodoItem.setTitle("Buy some milk")
        todoItemService.saveTodoItem(editedTodoItem)
        
        assertThat(todoItemService.todoItems, hasCount(5))
        assertThat(todoItemService.todoItems, hasItem(editedTodoItem))
        assertThat(todoItemService.todoItems, not(hasItem(addedTodoItem)))
    }
    
    
    func testRemoveItem() {
        let todoItem = TodoItem(title: "Buy milk")
        let addedTodoItem = todoItemService.addTodoItem(todoItem)
        assertThat(todoItemService.todoItems, hasCount(5))

        todoItemService.removeItem(addedTodoItem)
        assertThat(todoItemService.todoItems, hasCount(4))
        assertThat(todoItemService.todoItems, not(hasItem(addedTodoItem)))
    }
    
}
