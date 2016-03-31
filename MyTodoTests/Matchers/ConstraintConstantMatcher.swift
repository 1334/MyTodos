//
//  ConstraintConstantMatcher.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import Hamcrest
import UIKit



private func hasMatchingConstantConstraint(view: UIView, attribute: NSLayoutAttribute, constant: CGFloat) -> MatchResult {
    
    for constraint in view.constraints {
        if (constraint.firstAttribute == attribute &&
            constraint.constant == constant) {
            
            return .Match
        }
    }
    return .Mismatch(nil)
    
}

public func hasConstantConstraint<T:UIView>(attribute: NSLayoutAttribute, constant: CGFloat) -> Matcher<T> {
    return Matcher("view has contant value for \(descriptionOfAttribute(attribute)) of \(constant)") {
        (value: T) -> MatchResult in
        return hasMatchingConstantConstraint(value, attribute: attribute, constant: constant)
    }
}

public func hasHeightOf<T:UIView>(height: CGFloat) -> Matcher<T> {
    return hasConstantConstraint(.Height, constant: height)
}

public func hasWidthOf<T:UIView>(width: CGFloat) -> Matcher<T> {
    return hasConstantConstraint(.Width, constant: width)
}
