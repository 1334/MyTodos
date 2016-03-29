//
// Created by Rene Pirringer on 08.03.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

class TestNavigationController : UINavigationController {

	var _rootViewController: UIViewController?
	var _viewControllers:[UIViewController] = []
	var _wasDismissed: Bool = false
	var presentNotUsingWindow: Bool = false

	override init(rootViewController: UIViewController) {
		super.init(rootViewController: rootViewController)
		_rootViewController = rootViewController
		//_viewControllers.append(rootViewController)
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}


	override func presentViewController(viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
		super.presentViewController(viewControllerToPresent, animated: false, completion: completion)
	}

	override func setViewControllers(viewControllers: [UIViewController], animated: Bool) {
		super.setViewControllers(viewControllers, animated: false)
		_viewControllers = viewControllers
	}

	override func dismissViewControllerAnimated(flag: Bool, completion: (() -> Void)?) {
		super.dismissViewControllerAnimated(false, completion: completion)
		_wasDismissed = true
	}

	override func pushViewController(viewController: UIViewController, animated: Bool) {
		super.pushViewController(viewController, animated: false)
		_viewControllers.append(viewController)

		if (presentNotUsingWindow) {
			viewController.view.frame = UIScreen.mainScreen().bounds;
			viewController.viewWillAppear(false)
			viewController.viewWillLayoutSubviews()
			viewController.updateViewConstraints()
			viewController.view.layoutSubviews()
			viewController.viewDidLayoutSubviews()
			viewController.viewDidAppear(false)
		}
	}

	override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
		let result = super.popViewControllerAnimated(false)
		if let viewController = result {
			if let lastItem = _viewControllers.last {
				if (lastItem == viewController) {
					_viewControllers.removeLast()
				}
			}
		}
		return result
	}


	/*




- (NSArray *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
	NSInteger index = [_viewControllers indexOfObject:viewController];
	if (index == NSNotFound) {
		return [[NSArray alloc] init];
	}


	NSEnumerator *enumerator = [_viewControllers reverseObjectEnumerator];

	NSMutableArray *poppedViewControllers = [[NSMutableArray alloc] init];
	for (UIViewController *currentViewController in enumerator) {
		if (currentViewController == viewController) {
			break;
		}
		[poppedViewControllers addObject:currentViewController];
	}
	[super popToViewController:viewController animated:NO];
	[_viewControllers removeObjectsInArray:poppedViewControllers];
	return poppedViewControllers;
}


- (NSArray *)popToRootViewControllerAnimated:(BOOL)animated {
	return [self popToViewController:[_viewControllers firstObject] animated:NO];
}

- (void)dismissModalViewControllerAnimated:(BOOL)animated {
	[super dismissModalViewControllerAnimated:NO];
}


- (UIViewController *)visibleViewController {
	if (_visibleViewController) {
		return _visibleViewController;
	}
	return super.visibleViewController;
}

- (UIViewController *)topViewController {
	return [_viewControllers lastObject];
}

- (UINavigationBar *)navigationBar {
	UINavigationBar *navigationBar = [super navigationBar];
	if (!navigationBar) {
		navigationBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44.0f)];
	}
	return navigationBar;
}

- (UIViewController *)rootViewController {
	return [_viewControllers firstObject];
}


- (void)viewWillLayoutSubviews {
	[super viewWillLayoutSubviews];
	[self.rootViewController viewWillLayoutSubviews];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	// make sure that the view of the last view controller is loaded!!
	[[_viewControllers lastObject] view];
}

- (NSArray *)viewControllers {
	return _viewControllers;
}
*/
}
