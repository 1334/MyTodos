//
//  TodoItemClojures.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation

typealias TodoItemClosure  = (TodoItem) -> TodoItem
typealias AddTodoItemClosure = TodoItemClosure
typealias EditTodoItemClosure = TodoItemClosure