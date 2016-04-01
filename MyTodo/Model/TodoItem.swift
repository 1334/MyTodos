//
//  TodoItem.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation

class TodoItem: Equatable {
    
    static let newItemIdentifer = -1
    
    let title: String
    let done: Bool
    let identifier: Int
    
    init(identifier: Int, title: String, done: Bool) {
        self.identifier = identifier
        self.title = title
        self.done = done
    }
    
    convenience init?(dictionary: [String: AnyObject]) {
        let identifier = dictionary["identifier"] as? Int
        if identifier == nil {
            return nil
        }
        let title = dictionary["title"] as? String
        if title == nil {
            return nil
        }
        let done = dictionary["done"] as? Bool
        if done == nil {
            return nil
        }
        
        self.init(identifier: identifier!, title:title!, done:done!)
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
    
    func setDone(done: Bool) -> TodoItem {
        return TodoItem(identifier: self.identifier, title: self.title, done:done)
    }
    
    
    func asDictionary() -> [String: AnyObject] {
        return [
            "identifier": self.identifier,
            "title": self.title,
            "done": self.done
        ]
    }

}

func ==(lhs: TodoItem, rhs: TodoItem) -> Bool {
    return lhs.identifier == rhs.identifier &&
        lhs.title == rhs.title &&
        lhs.done == rhs.done
}

