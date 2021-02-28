//
//  LoginViewModel.swift
//  BasicDemo
//
//  Created by Admin on 16/02/21.
//

import Foundation
import SwiftyJSON
class LoginViewModel: NSObject {

    // MARK: - Variables
    
    ///
    var email = ""
    ///
    var password = ""
    
    /// password character minimum limit
    private let passwordCharMinLimit = 8
    
    /// This is login model
    //var loginModel: LoginModel!
    
    // MARK: - API Call
    
    /// loginApi
    ///
    /// - Parameters:
    ///   - success: return block success - empty
    ///   - failure: return block failure - response dic
    func loginApi(success: @escaping () -> Void, failure: @escaping (_ errorResponse: [String: Any]) -> Void) {
        let param: [String: Any] = ["email": email.removeWhiteSpace() ,
                                    "password": password]
        
       
        ApiManager.sharedInstance.multipartRequest(parameter: param, serverUrl: "", httpMethod: .post, success: { [weak self] (response) in
        
        }, failure: { (response, _) in
        
        })
    }
    
    func exampleNormalLoginRequest(success: @escaping () -> Void, failure: @escaping (_ errorResponse: [String: Any]) -> Void) {
        
        ProgressLoader.showProgressHudWithMessage()
        
        ApiManager.sharedInstance.requestFor(urlPath: "", parameter: nil, httpMethod: .get, includeHeader: true, success: { [weak self] (response) in
            
            ProgressLoader.hideProgressHud()
            
            let jsonData = JSON(response)
            
            if let mainData = jsonData["data"].dictionary, let successCode = mainData["code"] as? Int, successCode == 200 {
                
                success()
            } else {
                let dicError = CommonFunctions.getErrorDic(jsonData: jsonData)
                failure(dicError)
            }
           
        }, failure: { (responseDict, _) in
            ProgressLoader.hideProgressHud()
            failure(responseDict)
        })
    }
    
    // MARK: - Validation Login
    
    ///
    /// Validation for login
    ///
    /// - Parameter completion: completion return with bool and message string
    func validation(completion: @escaping (Bool, String) -> Void) {
        if email.isEmpty && password.removeWhiteSpace().isEmpty {
            completion(false, Messages.LoginScreen.strEmailAndPassValidMsg)
        } else if email.removeWhiteSpace().isEmpty {
            completion (false, Messages.LoginScreen.strEmailIdMsg)
        } else if email.isValidEmail() == false {
            completion (false, Messages.LoginScreen.strValidEmailIdMsg)
        } else if password.removeWhiteSpace().isEmpty {
            completion (false, Messages.LoginScreen.strpasswordMsg)
        } else {
            completion (true, "")
        }
    }
    
}
