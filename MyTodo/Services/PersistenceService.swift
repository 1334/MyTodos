//
//  PersistenceService.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation


protocol PersistenceService {
    
    
    func todoItems() -> [TodoItem]
    
    mutating func addTodoItem(todoItem:TodoItem) -> TodoItem
    mutating func saveTodoItem(todoItem:TodoItem) -> TodoItem
}