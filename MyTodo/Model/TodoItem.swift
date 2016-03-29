//
//  TodoItem.swift
//  MyTodo
//
//  Created by Workshop on 09/03/16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation

class TodoItem: NSObject {
    let title: String
    var done: Bool
    
    init(title: String) {
        self.title = title
        self.done = false
        super.init()
    }
}
