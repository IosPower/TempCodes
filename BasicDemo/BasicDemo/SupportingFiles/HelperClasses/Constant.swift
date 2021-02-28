//
//  Constant.swift
//  BasicDemo
//
//  Created by Admin on 12/02/21.
//

import UIKit

class Constant: NSObject {
    
    static let AppDel = UIApplication.shared.delegate as? AppDelegate
    ///
    static var navController: UINavigationController!
    ///
    static let window = Constant.AppDel?.window
    ///
    static let storeService = StorageService.shared
    
    ///
    
    static let defaults = UserDefaults.standard
    
    static var appDelegate = UIApplication.shared.delegate as? AppDelegate
        
    static var bottomSafeAreaHeight: CGFloat {
        var bottomSafeAreaHeight: CGFloat = 0
        if #available(iOS 11.0, *) {
            let window = UIApplication.shared.windows[0]
            let safeFrame = window.safeAreaLayoutGuide.layoutFrame
            bottomSafeAreaHeight = window.frame.maxY - safeFrame.maxY
        }
        return bottomSafeAreaHeight
    }
    
    static var viewNoRecord: UIView?
}

struct DeviceType {
    static let IS_IPHONE_5SOrSE = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 568.0
    static let IS_IPHONE_6Or6SOr7OR8 = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 667.0
    static let IS_IPHONE_6POr6SPOr7POr8P = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 736.0
    static let IS_IPHONE_X_Or_XS_Or_11Pro = UIDevice.current.userInterfaceIdiom == .phone && ScreenSize.SCREEN_MAX_LENGTH == 812.0
    static let IS_IPHONE_XR_Or_11_Or_11ProMax_Or_XsMax = UIDevice.current.userInterfaceIdiom
        == .phone && ScreenSize.SCREEN_MAX_LENGTH == 896.0
}

struct ScreenSize {
    static let SCREEN_WIDTH         = UIScreen.main.bounds.size.width
    static let SCREEN_HEIGHT        = UIScreen.main.bounds.size.height
    static let SCREEN_MAX_LENGTH    = max(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
    static let SCREEN_MIN_LENGTH    = min(ScreenSize.SCREEN_WIDTH, ScreenSize.SCREEN_HEIGHT)
}
