//
//  UINavigationControllerExtension.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 07/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit

extension UINavigationController{
    
    func pushViewController(identifier : String, animated : Bool = true){
        self.pushViewController(UIStoryboard.main().instantiateViewController(withIdentifier: identifier), animated: animated)
    }
}
