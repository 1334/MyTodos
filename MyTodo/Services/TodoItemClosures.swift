//
//  TodoItemClojures.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation


typealias TodoItemListResultClosure = ([TodoItem]?, NSError?) -> Void
typealias TodoItemResultClosure  = (TodoItem?, NSError?) -> Void

typealias TodoItemClosure  = (TodoItem, TodoItemResultClosure) -> Void
typealias AddTodoItemClosure = TodoItemClosure
typealias EditTodoItemClosure = TodoItemClosure