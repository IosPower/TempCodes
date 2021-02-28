//
//  TabbarService.swift
//  4SaleNbuy
//
//  Created by Admin on 07/12/20.
//

import  UIKit
/*
class TabbarService: NSObject {
    
    static var shared: TabbarService = TabbarService()
    
    var tabBarController = UITabBarController()
    
    private override init() {
        super.init()
        
    }
    
    func getTabbarController(selectedIndex: Int) -> UITabBarController {
        tabBarController.viewControllers = [getHomeNavigationController(), getCommercialAdNavigationController(), getPostAdNavigationController(), getMessagesNavigationController(), getmMoreSettingNavigationController()]
        tabBarController.selectedIndex = selectedIndex
        return tabBarController
    }

    /// get home navigation controller
    /// - Returns: navigation controller object
    private func getHomeNavigationController() -> UINavigationController {
        // home vc
        if StorageService.shared.loginDetail != nil {
            if StorageService.shared.loginDetail?.ID != "" {
                ChatFunctions().saveUpdatedProfilePic()
            }
        }
        
        let homeVC = UIStoryboard.storyboard(.home).instantiateViewController(HomeVC.self)
        homeVC.tabBarItem = UITabBarItem()
        homeVC.tabBarItem.image = UIImage(named: "ic_listing_unselected")?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.selectedImage = UIImage(named: "ic_listing_selected")?.withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)

        let navigationHome = UINavigationController(rootViewController: homeVC)
        navigationHome.navigationBar.isHidden = true
        navigationHome.interactivePopGestureRecognizer?.isEnabled = false
        return navigationHome
    }
    
    /// get commercial ad navigation controller
    /// - Returns: navigation controller object
    private func getCommercialAdNavigationController() -> UINavigationController {
        // commercialad vc
        let commercialAdVC = UIStoryboard.storyboard(.commercialAd).instantiateViewController(CommercialAdVC.self)
        commercialAdVC.tabBarItem = UITabBarItem()
        commercialAdVC.tabBarItem.image = UIImage(named: "ic_offers_unselected")?.withRenderingMode(.alwaysOriginal)
        commercialAdVC.tabBarItem.selectedImage = UIImage(named: "ic_offers_selected")?.withRenderingMode(.alwaysOriginal)
        commercialAdVC.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)

        flipTabbarImages(tabBarItem: commercialAdVC.tabBarItem)
        
        let navigationCommercialAd = UINavigationController(rootViewController: commercialAdVC)
        navigationCommercialAd.navigationBar.isHidden = true
        
        return navigationCommercialAd
    }
    
    /// get post  ad navigation controller
    /// - Returns: navigation controller object
    private func getPostAdNavigationController() -> UINavigationController {
        // postad vc
        let postAdVC = UIStoryboard.storyboard(.postAd).instantiateViewController(PostAdVC.self)
        postAdVC.tabBarItem = UITabBarItem()
        postAdVC.tabBarItem.image = UIImage(named: "ic_add_Post")?.withRenderingMode(.alwaysOriginal)
        postAdVC.tabBarItem.imageInsets = UIEdgeInsets(top: 15, left: 0, bottom: -5, right: 0)
        
        flipTabbarImages(tabBarItem: postAdVC.tabBarItem)
        
        let navigationPostAd = UINavigationController(rootViewController: postAdVC)
        navigationPostAd.navigationBar.isHidden = true
        
        return navigationPostAd
    }
    
    /// get messages navigation controller
    /// - Returns: navigation controller object
    private func getMessagesNavigationController() -> UINavigationController {
        // postad vc
        let messagesVC = UIStoryboard.storyboard(.messages).instantiateViewController(MessagesVC.self)
        messagesVC.tabBarItem = UITabBarItem()
        messagesVC.tabBarItem.image = UIImage(named: "ic_chat_unselected")?.withRenderingMode(.alwaysOriginal)
        messagesVC.tabBarItem.selectedImage = UIImage(named: "ic_chat_selected")?.withRenderingMode(.alwaysOriginal)
        messagesVC.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        
        flipTabbarImages(tabBarItem: messagesVC.tabBarItem)
        
        let navigationMessages = UINavigationController(rootViewController: messagesVC)
        navigationMessages.navigationBar.isHidden = true
        
        return navigationMessages
    }
    
    /// get more setting navigation controller
    /// - Returns: navigation controller object
    private func getmMoreSettingNavigationController() -> UINavigationController {
        // postad vc
        let moreSettingVC = UIStoryboard.storyboard(.moreSetting).instantiateViewController(MoreSettingVC.self)
        moreSettingVC.tabBarItem = UITabBarItem()
        moreSettingVC.tabBarItem.image = UIImage(named: "ic_more_unselected")?.withRenderingMode(.alwaysOriginal)
        moreSettingVC.tabBarItem.selectedImage = UIImage(named: "ic_more_selected")?.withRenderingMode(.alwaysOriginal)
        moreSettingVC.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        
        if Constant.defaults.value(forKey: UserDefaults.DefaultKeys.loginDetail) != nil {
           moreSettingVC.isFromLogin = false
        }
        
        flipTabbarImages(tabBarItem: moreSettingVC.tabBarItem)
        
        let navigationMoreSetting = UINavigationController(rootViewController: moreSettingVC)
        navigationMoreSetting.navigationBar.isHidden = true
        
        return navigationMoreSetting
    }
    
    func flipTabbarImages(tabBarItem: UITabBarItem) {
        if PreferredLanguage.language == LanguageCode.arabic.rawValue {
            let flipped = tabBarItem.image?.imageFlippedForRightToLeftLayoutDirection()
            tabBarItem.image = flipped
            
            let selectedImage = tabBarItem.selectedImage?.imageFlippedForRightToLeftLayoutDirection()
            tabBarItem.selectedImage = selectedImage
        }
    }
}
*/
extension UITabBarController {

    func getHeight() -> CGFloat {
        return self.tabBar.frame.size.height
    }

    func getWidth() -> CGFloat {
         return self.tabBar.frame.size.width
    }
}
