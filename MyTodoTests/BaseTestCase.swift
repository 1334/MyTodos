//
// Created by Rene Pirringer on 29.03.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import XCTest
import Hamcrest

class BaseTestCase: XCTestCase {

	static var window = UIWindow(frame:UIScreen.mainScreen().bounds)
	static var emptyViewController = UIViewController()

	var presentedViewController: UIViewController?

	override func tearDown() {
		super.tearDown()
		if let viewController = self.presentedViewController {
			viewController.dismissViewControllerAnimated(false, completion: nil)
			viewController.view.removeFromSuperview();
		}
		BaseTestCase.window.rootViewController = BaseTestCase.emptyViewController
		BaseTestCase.window.makeKeyAndVisible()
		presentedViewController = nil;
	}



	func presentViewController(let viewController: UIViewController, let useWindow: Bool = false) {
		presentedViewController = viewController;
		if (useWindow) {
			performPresentViewControllerUsingWindow(viewController)
		} else {
			performPresentViewController(viewController)
		}
	}


	private func performPresentViewController(let viewController: UIViewController) {
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


	private func performPresentViewControllerUsingWindow(let viewController: UIViewController) {
		BaseTestCase.window.layer.speed = 10;
		BaseTestCase.window.rootViewController = viewController;
		BaseTestCase.window.makeKeyAndVisible();
		if (!CGRectEqualToRect(BaseTestCase.window.frame, viewController.view.frame)) {
			viewController.view.frame = BaseTestCase.window.frame;
		}
		CATransaction.commit();
	}


}
