//
//  AppDelegate.swift
//  BasicDemo
//
//  Created by Admin on 12/02/21.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        appLaunchSetup()
        return true
    }
    
    /// setup when the app is launching
    func appLaunchSetup() {
        
        // ApiManager initialize
        _ = ApiManager.sharedInstance
        
        // build environment set
        ApiConfiguration.sharedInstance.buildEnvironment = .development

        // status bar light
        //UIApplication.shared.statusBarStyle = .lightContent
    
        //IQKeyboardManager setup
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = false
//        UITextField.appearance().tintColor = .white
//        UITextView.appearance().tintColor = .white
    }
    
//    /// if we have already login so navigate to dashboard vc when we launch app, and if we login first time so navigate to login vc
//    func navigationSetup() {
//        var isShowAdvertise = false
//        guard let navController = UIStoryboard.storyboard(.login).instantiateViewController(withIdentifier: "navigationVC") as? UINavigationController else { return }
//
//        guard isAlreadyLogin() else {
//            navigateToLoginVC(withNavController: navController)
//            getBanner(isShowAdvertise: isShowAdvertise, notificationName: nil)
//            return
//        }
//        if let robotoFont = UIFont(name: "Roboto-Medium", size: 20) {
//            navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: robotoFont, NSAttributedString.Key.foregroundColor: UIColor.white]
//        }
//        guard let loginModel = Constant.storeService.loginDetail else {
//            navigateToLoginVC(withNavController: navController)
//            getBanner(isShowAdvertise: isShowAdvertise, notificationName: nil)
//            return
//        }
//        isShowAdvertise = true
//        var notificationName = ""
//        if !loginModel.isPreference {
//            navigateToSetPreferenceVC(withNavController: navController)
//            notificationName = AdvertisementNotification.setPreference.rawValue
//        } else if !loginModel.isProject {
//            navigateToCreateProjectVC(withNavController: navController)
//            notificationName = AdvertisementNotification.createProject.rawValue
//        } else {
//            navigateToDashboardVC(withNavController: navController)
//            notificationName = AdvertisementNotification.dashboard.rawValue
//        }
//        getBanner(isShowAdvertise: isShowAdvertise, notificationName: notificationName)
//    }
    
    // MARK: - Login Check And Fetch Login Details
    
    /// this method is used to check, already logged in or not, in this method we are checking true or false value in userdefault
    func isAlreadyLogin() -> Bool {
        return Constant.storeService.isLogin ?? false
    }
}

