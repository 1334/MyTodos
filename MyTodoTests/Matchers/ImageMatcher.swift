//
//  ImageMatcher.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import Hamcrest
import UIKit


public func equalToImage<T:UIImage>(image: UIImage) -> Matcher<T> {
    return Matcher("image is equal") {
        (value: T) -> MatchResult in
        
        
        if let firstImageData = UIImagePNGRepresentation(value) {
            if let secondImageData = UIImagePNGRepresentation(image) {
                if firstImageData.isEqualToData(secondImageData) {
                    return .Match
                }
            }
        }
        return .Mismatch(nil)
    }
}
