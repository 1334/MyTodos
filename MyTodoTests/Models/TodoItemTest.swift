//
//  TodoItemTest.swift
//  MyTodo
//
//  Created by Rene Pirringer on 30.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import Hamcrest
@testable import MyTodo


class TodoItemTest : XCTestCase {
    
    
    func testCreateWithTitle() {
        let todoItem = TodoItem(title: "Buy milk")
        assertThat(todoItem.title, equalTo("Buy milk"))
        assertThat(todoItem.identifier, equalTo(TodoItem.newItemIdentifer))
        assertThat(todoItem.done, equalTo(false))
    }
    
    func testNewTitle() {
        let todoItem = TodoItem(title: "Buy milk")
        let newTodoItem = todoItem.setTitle("Buy some milk")
        assertThat(newTodoItem, not(equalTo(todoItem)))
    }
    
    
}