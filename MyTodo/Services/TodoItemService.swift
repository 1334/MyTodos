//
//  TodoItemService.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation


protocol TodoItemService {
    var todoItems: [TodoItem] { get }
    func addTodoItem(item: TodoItem) -> TodoItem
    func saveTodoItem(item: TodoItem) -> TodoItem
    func removeItem(item: TodoItem) -> TodoItem?
}