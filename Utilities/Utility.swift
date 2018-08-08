//
//  Utility.swift
//  PharmEasy_Assgn
//
//  Created by Ashutosh Lasod on 07/08/18.
//  Copyright © 2018 Ashutosh Lasod. All rights reserved.
//

import UIKit
import SystemConfiguration

class Utility: NSObject {
    
    static func showError(withMessage message:String, onViewController vc:UIViewController){
        let alertController = UIAlertController.init(title: Constant.ERROR, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: Constant.OK, style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    static func showMessage(withTitle title: String, andMessage message:String, onViewController vc:UIViewController, okTappedCallback : @escaping ()-> ()){
        let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Ok", style: .default) { (alertAction) in
            okTappedCallback()
        }
        alertController.addAction(alertAction)
        vc.present(alertController, animated: true, completion: nil)
    }
    
    static func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, zeroSockAddress)
            }
        }
        
        var flags: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) == false {
            return false
        }
        
        let isReachable = flags == .reachable
        let needsConnection = flags == .connectionRequired
        
        return isReachable && !needsConnection
        
    }

}
