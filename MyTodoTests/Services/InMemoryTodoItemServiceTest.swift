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

class InMemoryTodoItemServiceTest : XCTestCase {
    
    let todoItemService = InMemoryTodoItemService()

    override func setUp() {
        todoItemService.addTodoItem(TodoItem(title: "Buy Milk"))
        todoItemService.addTodoItem(TodoItem(title: "Buy Beer"))
        todoItemService.addTodoItem(TodoItem(title: "Drink Beer"))
        todoItemService.addTodoItem(TodoItem(title: "World Domination"))
    }

    func testAddTodoItem() {
        let todoItem = TodoItem(title: "Buy milk")
        let addedTodoItem = todoItemService.addTodoItem(todoItem)
        
        assertThat(addedTodoItem, not(equalTo(todoItem)))
        assertThat(addedTodoItem.title, equalTo(todoItem.title))
        assertThat(addedTodoItem.identifier, not(equalTo(TodoItem.newItemIdentifer)))

        todoItemService.withTodoItems() { todoItems in
            assertThat(todoItems, hasItem(addedTodoItem))
            assertThat(todoItems, hasCount(5))
        }
    }
    
    func testTodoItemHasChanged() {
        let todoItem = TodoItem(title: "Buy milk")
        let addedTodoItem = todoItemService.addTodoItem(todoItem)
        assertThat(todoItemService.todoItems, hasCount(5))

        let editedTodoItem = addedTodoItem.setTitle("Buy some milk")
        todoItemService.saveTodoItem(editedTodoItem)
        
        todoItemService.withTodoItems() {
            todoItems in
            assertThat(todoItems, hasCount(5))
            assertThat(todoItems, hasItem(editedTodoItem))
            assertThat(todoItems, not(hasItem(addedTodoItem)))
        }
    }
    
    
    func testRemoveItem() {
        let todoItem = TodoItem(title: "Buy milk")
        let addedTodoItem = todoItemService.addTodoItem(todoItem)
        assertThat(todoItemService.todoItems, hasCount(5))

        todoItemService.removeTodoItem(addedTodoItem)

        todoItemService.withTodoItems() {
            todoItems in
            assertThat(todoItems, hasCount(4))
            assertThat(todoItems, not(hasItem(addedTodoItem)))
        }
    }
    
}
