//
//  ViewControllerTestExtension.swift
//  MyTodo
//
//  Created by Rene Pirringer on 04.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import Hamcrest


extension XCTest {

	func presentViewController(let viewController: UIViewController) {
		assertThat(viewController.view, instanceOf(UIView))

		/*
		if ([viewController isKindOfClass:[TestNavigationController class]]) {
		TestNavigationController *navigationController = (TestNavigationController*)viewController;
		navigationController.presentNotUsingWindow = YES;
		assertThat([navigationController.visibleViewController view], is(notNilValue()));
		}
		*/

		viewController.viewWillAppear(false)
		var bounds = UIScreen.mainScreen().bounds
		if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_7_1) {
			if (UIInterfaceOrientationIsLandscape(UIApplication.sharedApplication().statusBarOrientation)) {
				bounds.size = CGSizeMake(bounds.size.height, bounds.size.width);
			}
		}
		viewController.view.frame = bounds;
		viewController.viewWillLayoutSubviews()
		viewController.updateViewConstraints()
		viewController.view.layoutSubviews()
		viewController.viewDidLayoutSubviews()
		viewController.viewDidAppear(false)
	}
}
