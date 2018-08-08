//
//  Constant.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 07/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit

class Constant: NSObject {
    
    //MARK: Screen size constants
    static let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.size.height
    static let IS_IPAD = (UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad)
    
    //MARK: ERROR Constants
    static let INTERNET_NOT_AVAILABLE_ERROR_MESSAGE = "Internet connection not available!"
    static let ERROR = "Error"
    static let OK = "OK!"
    static let ERROR_FETCHING_DATA = "Error in fetching data from server!"
    static let ERROR_DOWNLOADING_IMAGE = "Error downloading the image"
    static let USER_ID_LABEL = "User ID : "
    static let USER_NAME_LABEL = "User Name : "
    
    //MARK: VC IDENTIFIERS
    static let ID_STORYBOARD = "Main"
    static let ID_DETAIL_VC = "DetailViewController"
    static let ID_VC_CELL_TABLE_IDENTIFIER = "HomeCell"
    
}
