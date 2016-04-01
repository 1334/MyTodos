//
//  TodoItemService.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation



protocol TodoItemService {
    func todoItems(result: TodoItemListResultClosure)
    func addTodoItem(item: TodoItem, result: TodoItemResultClosure)
    func saveTodoItem(item: TodoItem, result: TodoItemResultClosure)
    func removeTodoItem(item: TodoItem, result: TodoItemResultClosure)
}