//
//  AppDelegateTest.swift
//  MyTodo
//
//  Created by Rene Pirringer on 26.02.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import XCTest
import Hamcrest

class AppDelegateTest: XCTestCase {
	var applicationDelegate:UIApplicationDelegate = UIApplication.sharedApplication().delegate!
	
	func testRootViewController() {
		let navigationController = applicationDelegate.window!!.rootViewController!
		assertThat(navigationController, instanceOf(UINavigationController))
	}
	
}
