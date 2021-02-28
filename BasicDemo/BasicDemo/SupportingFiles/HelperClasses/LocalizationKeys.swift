//
//  LocalizationKeys.swift
//  4SaleNbuy
//
//  Created by Admin on 07/12/20.
//

import UIKit

struct LocalizationKeys {

    struct PaymentWebview {
        static let paymentSuccessKey = "paymentSuccessKey"
        static let paymentfailKey = "paymentfailKey"
    }

    struct LocalMessages {
        ///
        static let appTitle = "4SaleNbuy"
        ///
        static let chooseGallary = "Choose from Photo gallery."
        ///
        static let captureImage = "Capture Image."
    }
}

struct PreferredLanguage {
    static var language: String {
        if let language = Constant.storage.preferedLanguage {
            if language == LanguageCode.arabic.rawValue {
                return LanguageCode.arabic.rawValue
            }
        }
        return LanguageCode.eng.rawValue
    }
}
