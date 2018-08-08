//
//  UIStoryboardExtension.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 07/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit

extension UIStoryboard{
    
    class public func main() -> UIStoryboard {
        return self.init(name: Constant.ID_STORYBOARD, bundle: nil)
    }
    
}
