//
//  ConstraintEqualMatcher.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import Hamcrest
import UIKit

private func hasMatchingEqualConstraint(view: UIView, firstAttribute: NSLayoutAttribute, secondAttribute: NSLayoutAttribute) -> MatchResult {

    if let superView = view.superview {

        for constraint in superView.constraints {

            if (constraint.firstItem === view &&
          			constraint.secondItem === superView &&
          			constraint.firstAttribute == firstAttribute &&
          			constraint.secondAttribute == secondAttribute &&
          			constraint.relation == NSLayoutRelation.Equal &&
          			constraint.constant == 0) {
                return .Match
            }
        }
    }


    return .Mismatch(nil)

}


public func hasEqualConstraint<T:UIView>(attribute: NSLayoutAttribute) -> Matcher<T> {
    return Matcher("view has equal constraint: \(descriptionOfAttribute(attribute))") {
        (value: T) -> MatchResult in
        return hasMatchingEqualConstraint(value, firstAttribute: attribute, secondAttribute:attribute)
    }
}

public func isVerticalCenter<T:UIView>() -> Matcher<T> {
    return hasEqualConstraint(.CenterY)
}

public func isHorizontalCenter<T:UIView>() -> Matcher<T> {
    return hasEqualConstraint(.CenterY)
}

public func isCenter<T:UIView>() -> Matcher<T> {
    return allOf(isHorizontalCenter(), isVerticalCenter())
}

public func hasSameSize<T:UIView>() -> Matcher<T> {
    return Matcher("view has same size") {
        (value: T) -> MatchResult in
        return hasMatchingEqualConstraint(value, firstAttribute: .Width, secondAttribute:.Height)
    }
}