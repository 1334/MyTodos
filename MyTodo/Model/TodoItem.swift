//
//  TodoItem.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation

class TodoItem: NSObject {
    
    static let newItemIdentifer = -1
    
    let title: String
    let done: Bool
    let identifier: Int
    
    init(identifier: Int, title: String, done: Bool) {
        self.identifier = identifier
        self.title = title
        self.done = done
    }

    convenience init(identifier: Int, title: String) {
        self.init(identifier:identifier, title:title, done:false)
    }

    convenience init(title: String) {
        self.init(identifier:TodoItem.newItemIdentifer, title:title, done:false)
    }
    
    func setTitle(title: String) -> TodoItem {
        return TodoItem(identifier: self.identifier, title: title, done:self.done)
    }
    

}


func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
    return lhs.identifier == rhs.identifier &&
        lhs.title == rhs.title &&
        lhs.done == rhs.done
}