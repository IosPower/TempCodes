//
//  UserModel.swift
//  BasicDemo
//
//  Created by Admin on 28/02/21.
//

import Foundation
import SwiftyJSON

/// LoginModel contains userDetails Parameters
class UserModel: Codable {
    // MARK: - Variables

    ///
    var firstName: String = ""
    ///
    var lastName: String = ""
    ///
    var email: String = ""
    ///
    var password: String = ""
    ///
    var is_term_accept = 1
    ///
    var role = 3
    ///
    var dob: String = ""
    ///
    var gender = 1
    ///
    var address: String = ""
    ///
    var address_lat: String = ""
    ///
    var address_long: String = ""
    ///
    var company_name: String = ""
    ///
    var contact_person: String = ""
    ///
    var phone: String = ""
    ///
    var category = 1
    ///
    var referral_code = 1234
    ///
    var instagram_client_id = 1234
    ///
    var tripadvisor_client_id = 1234
   
    // MARK: - Initialize

    ///
    convenience init(json: JSON?, imagePath: String?) {
        self.init()
        guard let jsonResponse = json else {
            return
        }
        firstName = jsonResponse["firstName"].stringValue
        lastName = jsonResponse["lastName"].stringValue

    }
}
