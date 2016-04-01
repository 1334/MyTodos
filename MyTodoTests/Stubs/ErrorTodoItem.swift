//
// Created by Rene Pirringer on 01.04.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
@testable import MyTodo

class ErrorTodoItem : TodoItem {

    init() {
        super.init(identifier:0, title:"ErrorTodoItem indicates that something is wrong!", done:false)
    }

    override func setTitle(title: String) -> TodoItem {
        XCTFail("ErrorTodoItem indicates that something is wrong!")
        return super.setTitle(title)
    }

    override func setDone(done: Bool) -> TodoItem {
        XCTFail("ErrorTodoItem indicates that something is wrong!")
        return super.setDone(done)
    }

    override func asDictionary() -> [String:AnyObject] {
        XCTFail("ErrorTodoItem indicates that something is wrong!")
        return super.asDictionary()
    }

}
