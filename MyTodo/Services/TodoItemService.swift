//
//  TodoItemService.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation

class TodoItemService: NSObject {
    var todoItems : [TodoItem] = [ TodoItem(title: "Buy Milk"), TodoItem(title: "Buy Beer"), TodoItem(title: "Drink Beer"), TodoItem(title: "World Domination")]

    func addTodoItem(item: TodoItem) {
        self.todoItems.append(item)
    }
}
