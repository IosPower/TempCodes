//
//  ProgressLoader.swift
//  BasicDemo
//
//  Created by Admin on 12/02/21.
//

import SVProgressHUD

class ProgressLoader: NSObject {
        
    class func showProgressHudWithMessage(message: String = "", isForError: Bool = false) {
        SVProgressHUD.setDefaultAnimationType(SVProgressHUDAnimationType.native)
        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
        
        if isForError {
            SVProgressHUD.showError(withStatus: message)
        } else {
            SVProgressHUD.show(withStatus: message)
        }
    }
    
    class func hideProgressHud() {
        SVProgressHUD.dismiss()
    }
}
