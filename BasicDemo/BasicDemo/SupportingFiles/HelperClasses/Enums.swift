//
//  Enums.swift
//  BasicDemo
//
//  Created by Admin on 28/02/21.
//

import UIKit

enum Storyboard: String {
    ///
    case main = "Main"
    ///
    case home = "Home"
   
    var filename: String {
        return rawValue
    }
}

enum LanguageCode: String {
    case eng = "en"
    case arabic = "ar"
}
