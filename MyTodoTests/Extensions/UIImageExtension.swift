//
//  UIImageExtension.swift
//  MyTodo
//
//  Created by Rene Pirringer on 31.03.16.
//  Copyright © 2016 Rene Pirringer. All rights reserved.
//

import Foundation
import UIKit

func ==(lhs: UIImage, rhs: UIImage) -> Bool
{
    guard let data1 = UIImagePNGRepresentation(lhs),
        data2 = UIImagePNGRepresentation(rhs)
        else { return false }
    
    return data1.isEqual(data2)
}