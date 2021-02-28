//
//  ApiConfiguration.swift
//  BasicDemo
//
//  Created by Admin on 12/02/21.
//
import UIKit

/// This will give base URL for API call according to the environment.
class ApiConfiguration: NSObject {

    ///
    private let host = "http://xyz.com"
    ///
    var baseURL: String = ""
    ///
    var serverURL: String = ""
    /// Time Interval in second for request time out
    static let timeoutIntervalForRequest = 100.0
    /// Time Interval in second for resource time out
    static let timeoutIntervalForResource = 100.0
    // MARK: - Init
    ///
    fileprivate override init() {
        // build environment set
        self.buildEnvironment = .production
        super.init()
    }
    ///
    class var sharedInstance: ApiConfiguration {
        struct Static {
            static var instance: ApiConfiguration?
            static var token: Int = 0
        }
        if Static.instance == nil {
            Static.instance = ApiConfiguration()
        }
        return Static.instance ?? ApiConfiguration()
    }
    /// Setup build environment for application.
    var buildEnvironment: DevelopmentEnvironment {
        didSet {
            switch buildEnvironment {
            case .production:
                baseURL = ""
            case .staging:
                baseURL = ""
            case .development:
                baseURL = "\(host)/wp-json/wpsisapi/v1"
            default:
                baseURL = ""
            }
            serverURL = baseURL + "/"
        }
    }
}

enum DevelopmentEnvironment: String {
  ///
  case development = "Development"
  ///
  case production = "Production"
  ///
  case local = "Local"
  ///
  case staging = "Staging"
}
