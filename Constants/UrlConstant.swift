//
//  UrlConstant.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 07/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit

class UrlConstant: NSObject {

    class func getBaseURL(forPage pageNumber:Int,andDataPerPage dataPerPage: Int) -> String {
        return "https://reqres.in/api/users?page=\(pageNumber)&per_page=\(dataPerPage)"
    }
}
