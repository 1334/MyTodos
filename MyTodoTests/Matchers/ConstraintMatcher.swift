//
// Created by Rene Pirringer on 04.03.16.
// Copyright (c) 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import Hamcrest
import UIKit


private func findSuperView(first:UIView, _ second:UIView) -> UIView? {

	var view = first
	while let superview = view.superview {
		if (superview == second) {
			return superview
		}
		view = superview
	}
	return findSuperView(first, second.superview)
}

public func findSuperView(first:UIView?, _ second:UIView?) -> UIView? {
	if let f = first {
		if let s = second {
			return findSuperView(f, s)
		}
	}
	return nil
}

private func hasMatchingConstraint(view: UIView, to: AnyObject?, attribute: NSLayoutAttribute, gap: CGFloat) -> MatchResult {

	if let commonSuperView = findSuperView(view, view.superview) {

		if let toItem = to {

			var firstAttribute = attribute
			var secondAttribute = attribute
			var firstItem: AnyObject = view
			var secondItem: AnyObject = toItem

			if (commonSuperView != view && commonSuperView != view.superview ) {
				secondAttribute = inverseAttribute(attribute)
			}

			if (commonSuperView !== secondItem) {
				secondAttribute = inverseAttribute(attribute)
			}

			if (toItem is UILayoutSupport) {
				secondAttribute = inverseAttribute(attribute)
			}


			if (attribute == .Bottom || attribute == .Right || attribute == .Trailing) {
				swap(&firstItem, &secondItem)
				swap(&firstAttribute, &secondAttribute)
			}

			for constraint in commonSuperView.constraints {

				if (constraint.firstAttribute == firstAttribute &&
								constraint.secondAttribute == secondAttribute &&
								constraint.firstItem === firstItem &&
								constraint.secondItem === secondItem &&
								constraint.relation == NSLayoutRelation.Equal &&
								constraint.constant == gap) {
					return .Match
				}
			}
		}
	}
	return .Mismatch(nil)
}





public func isPinned<T:UIView>(attribute: NSLayoutAttribute, toView: UIView?, gap: CGFloat) -> Matcher<T> {
	return Matcher("view is pinned \(descriptionOfAttribute(attribute)) to its superview") {
		(value: T) -> MatchResult in
		if let toViewUnwrapped = toView {
			return hasMatchingConstraint(value, to: toViewUnwrapped, attribute: attribute, gap: gap)
		} else {
			return hasMatchingConstraint(value, to: value.superview, attribute: attribute, gap: gap)
		}
	}
}

public func isPinned<T:UIView>(attribute: NSLayoutAttribute, toView: UIView?) -> Matcher<T> {
	return isPinned(attribute, toView: toView, gap: 0)
}

public func isPinned<T:UIView>(attribute: NSLayoutAttribute) -> Matcher<T> {
	return isPinned(attribute, toView: nil, gap: 0)
}


public func isPinned<T:UIView>(attribute: NSLayoutAttribute, gap: CGFloat) -> Matcher<T> {
	return isPinned(attribute, toView: nil, gap: gap)
}

public func isPinned<T:UIView>(attribute: NSLayoutAttribute, to: AnyObject?, gap: CGFloat) -> Matcher<T> {
	return Matcher("view is pinned \(descriptionOfAttribute(attribute)) to its superview") {
		(value: T) -> MatchResult in
		return hasMatchingConstraint(value, to: to, attribute: attribute, gap: gap)
	}
}

public func isPinned<T:UIView>(attribute: NSLayoutAttribute, to: AnyObject?) -> Matcher<T> {
	return isPinned(attribute, to: to, gap: 0)
}


public func descriptionOfAttribute(attribute:NSLayoutAttribute) -> String {
	switch attribute {
		case .Left:
			return "Left"
		case .Right:
			return "Right"
		case .Top:
			return "Top"
		case .Bottom:
			return "Bottom"
		case .Leading:
			return "Leading"
		case .Trailing:
			return "Trailing"
		case .Width:
			return "Width"
		case .Height:
			return "Height"
		case .CenterX:
			return "CenterX"
		case .CenterY:
			return "CenterY"
		case .Baseline:
			return "Baseline"
		case .FirstBaseline:
			return "FirstBaseline"
		case .LeftMargin:
			return "LeftMargin"
		case .RightMargin:
			return "RightMargin"
		case .TopMargin:
			return "TopMargin"
		case .BottomMargin:
			return "BottomMargin"
		case .LeadingMargin:
			return "LeadingMargin"
		case .TrailingMargin:
			return "TrailingMargin"
		case .CenterXWithinMargins:
			return "CenterXWithinMargins"
		case .CenterYWithinMargins:
			return "CenterYWithinMargins"
		case .NotAnAttribute:
			return "NotAnAttribute"
	}

}


func inverseAttribute(attribute: NSLayoutAttribute) -> NSLayoutAttribute {
	switch (attribute) {
	case .Top:
		return .Bottom;
	case .Bottom:
		return .Top;
	case .Right:
		return .Left;
	case .Left:
		return .Right;
	case .Leading:
		return .Trailing
	case .Trailing:
		return .Leading
	default:
		return attribute;
	}
}

func swap(inout first: Any, inout _ second: Any) {
	let tmp = first
	second = first
	first = tmp
}

