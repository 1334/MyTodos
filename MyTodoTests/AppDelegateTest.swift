//
//  AppDelegateTest.swift
//  MyTodo
//
//  Created by Rene Pirringer on 26.02.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import XCTest
import Hamcrest
@testable import MyTodo

class AppDelegateTest: XCTestCase {
	var applicationDelegate:UIApplicationDelegate = UIApplication.sharedApplication().delegate!

	func testRootViewController() {
		assertThat(getNavigationController(), instanceOf(UINavigationController))
	}
    
    func testRootViewControllerContainsTodoViewController() {
        let navigationController = getNavigationController()
        
        assertThat(navigationController.topViewController!, instanceOf(TodoListViewController))
    }
    
    func getNavigationController() -> UINavigationController {
        if let windowOptional = applicationDelegate.window {
            if let window = windowOptional {
                if let rootViewController = window.rootViewController as? UINavigationController {
                    return rootViewController
                } else {
                    XCTFail("RootViewController is empty!")
                }
            }
        }
        XCTFail("Window is empty!")
        
        return UINavigationController()
    }
}
