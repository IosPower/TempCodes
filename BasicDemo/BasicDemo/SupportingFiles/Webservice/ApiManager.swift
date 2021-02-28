//
//  ApiManager.swift
//  BasicDemo
//
//  Created by Admin on 12/02/21.
//
import UIKit
import Reachability
import Alamofire

/// ApiManager for call webservice class
class ApiManager: NSObject {
    ///
    var isInternetAvailable: Bool = true
    ///
    fileprivate var reachability: Reachability?
    ///
    static let sharedManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = ApiConfiguration.timeoutIntervalForResource
        configuration.timeoutIntervalForResource = ApiConfiguration.timeoutIntervalForResource
        return Alamofire.Session(configuration: configuration)
    }()
    ///
    class var sharedInstance: ApiManager {
        struct Static {
            static var instance: ApiManager?
            static var token: Int = 0
        }
        if Static.instance == nil {
            Static.instance = ApiManager()
        }
        return Static.instance ?? ApiManager()
    }
    ///
    private override init() {
        super.init()
        reachability = try? Reachability.init()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged), name: Notification.Name.reachabilityChanged, object: reachability)
        do {
            try reachability?.startNotifier()
        } catch let error {
            print("error rechability", error.localizedDescription)
        }
    }
    ///
    private func createBodyWithParameters(parameters: NSDictionary) -> Data {
        var jsonData: Data = Data()
        do {
            jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch let error as NSError {
            print(error)
        }
        return jsonData
    }
    
    
    // MARK: - Request Method
    

    /// request api
    /// - Parameters:
    ///   - urlPath: urlPath in string
    ///   - parameter: parameter dictionary
    ///   - httpMethod: httpMethod
    ///   - includeHeader: includeHeader bool
    ///   - isAddAccessToken: isAddAccessToken bool
    ///   - success: success block
    ///   - failure: failure block
    func requestFor(urlPath: String, parameter: [String: Any]?, httpMethod: HTTPMethod, includeHeader: Bool = true, isAddAccessToken: Bool = false, success:@escaping (_ response: [String: Any]) -> Void, failure:@escaping (_ response: [String: Any], _ error: Error?) -> Void) {
        
        URLCache.shared.removeAllCachedResponses()
        
        let completeURL = ApiConfiguration.sharedInstance.serverURL + urlPath
        
        guard isInternetAvailable else {
            ProgressLoader.hideProgressHud()
            Constant.window?.showInternetAlert()
            return
        }
        
        var headerParam: HTTPHeaders?
        if includeHeader {
            let strToken = "1! ^>/vgJP*n f@zvm1z|_qUzVoBOE)o8NU?`4jA{O4,4apHc.ig^{CyF`W?*+.a"
            headerParam = [ModelKeys.ApiHeaderKeys.contentType: ModelKeys.ApiHeaderKeys.applicationContentType,
                           ModelKeys.ApiHeaderKeys.apikey: strToken]
        }
        
        if isAddAccessToken {
            headerParam?[ModelKeys.ApiHeaderKeys.accessToken] = Constant.storage.strToken ?? ""
        }
        
        print("headerParam :-- ", headerParam ?? "")
        
        ApiManager.sharedManager.request(completeURL, method: httpMethod, parameters: parameter, encoding: JSONEncoding.default, headers: headerParam).validate().responseJSON { response in
            
            print("Response:-", response)
            
            switch response.result {
            case .success:
                if let responseDict = response.value as? [String: Any] {
                    print("responseDict :-- ", responseDict)
                    success(responseDict)
                } else {
                    failure([ModelKeys.ResponseKeys.message: Messages.Common.somethingWrong], response.error)
                }
            case .failure (let error):
                if let responseDict = response.value as? [String: Any] {
                    failure(responseDict, response.error)
                } else {
                    print(error.localizedDescription)
                    print(error._code)
                    self.getFailResponse(encodingError: error, failure: { (reponseDic) in
                        failure(reponseDic, error)
                    })
                }
            }
        }
    }
    
    /// Custom Multipart API Calling methods. We can call any rest API With this common API calling method.
    /// - Parameters:
    ///   - parameter: parameter dictionary
    ///   - serverUrl: server url
    ///   - httpMethod: http Method.
    ///   - isAddAccessToken: isAddAccessToken is used to authenticate for api
    ///   - arrImages: array of images
    ///   - arrImageKeys: array of images keys
    ///   - arrVideosData: array of videos data
    ///   - arrVideoKeys: array of videos keys
    ///   - fileUploadData: file data for upload
    ///   - fileType: file type
    ///   - success: success block.
    ///   - failure: failure block.
    func multipartRequest(parameter: [String: Any]?, serverUrl: String, httpMethod: HTTPMethod, isAddAccessToken: Bool = true, arrImages: [UIImage] = [], arrImageKeys: [String] = [], arrVideosData: [Data] = [], arrVideoKeys: [String] = [], fileUploadData: Data? = nil, fileType: String = "", success:@escaping(_ response: [String: Any]) -> Void, failure:@escaping (_ response: [String: Any], _ error: Error?) -> Void) {
        
        URLCache.shared.removeAllCachedResponses()
        
        let completeURL = ApiConfiguration.sharedInstance.serverURL + serverUrl
        
        print("completeURL :-- ", completeURL)
        print("param :-- ", parameter ?? "")
        
        // Set header
        let strToken = "1! ^>/vgJP*n f@zvm1z|_qUzVoBOE)o8NU?`4jA{O4,4apHc.ig^{CyF`W?*+.a"
        var headerParam: HTTPHeaders = [ModelKeys.ApiHeaderKeys.contentType: ModelKeys.ApiHeaderKeys.applicationContentType,
                                        ModelKeys.ApiHeaderKeys.apikey: strToken]
        
        if isAddAccessToken {
            headerParam[ModelKeys.ApiHeaderKeys.accessToken] = Constant.storage.strToken ?? ""
        }
        
        print("headerParam :-- ", headerParam)
        guard isInternetAvailable else {
            // Show alert on window
            ProgressLoader.hideProgressHud()
            Constant.window?.showInternetAlert()
            return
        }
        
        AF.upload(multipartFormData: { multipartFormData in
            
            if let param = parameter {
                for (key, value) in (param) {
                    guard let data = "\(value)".data(using: String.Encoding.utf8) else { continue }
                    multipartFormData.append(data, withName: key as String)
                }
            }
            
            if arrImages.count > 0, arrImageKeys.count == arrImages.count {
                for (index, image) in arrImages.enumerated() {
                    let imageKey = arrImageKeys[index]
                    guard let data = image.jpegData(compressionQuality: 1.0) else {
                        continue
                    }
                    let imageName = "iosImage\(Date().timeIntervalSince1970).jpg"
                    multipartFormData.append(data, withName: imageKey, fileName: imageName, mimeType: ModelKeys.MimeType.jpg)
                }
            }
            
            if arrVideosData.count > 0, arrVideoKeys.count == arrVideosData.count {
                for (index, dataVideo) in arrVideosData.enumerated() {
                    let videoKey = arrVideoKeys[index]
                    let videoName = "iosFile\(Date().timeIntervalSince1970).mp4"
                    multipartFormData.append(dataVideo, withName: videoKey, fileName: videoName, mimeType: ModelKeys.MimeType.videoMp4)
                }
            }
        
            if let fileData = fileUploadData, !fileData.isEmpty {
                let itemName = String(format: "iosVideo\(NSDate().timeIntervalSince1970).\(fileType)")
                multipartFormData.append(fileData, withName: "file", fileName: itemName, mimeType: fileType)
            }

        },
        to: completeURL, method: .post, headers: headerParam)
        .responseJSON(completionHandler: { (response) in
            
            switch response.result {
            case .success:
                if let responseDict = response.value as? [String: Any] {
                    print("ResponseDict:-", response)
                    success(responseDict)
                } else {
                    failure([ModelKeys.ResponseKeys.message: Messages.Common.somethingWrong], response.error)
                }
            case .failure (let error):
                if let responseDict = response.value as? [String: Any] {
                    failure(responseDict, response.error)
                } else {
                    print(error.localizedDescription)
                    print(error._code)
                        self.getFailResponse(encodingError: error, failure: { (reponseDic) in
                        failure(reponseDic, error)
                    })
                }
            }
        })
    }
    
    // MARK: - Fail Response
    /// getFailResponse
    ///
    /// - Parameters:
    ///   - encodingError: encodingError
    ///   - failure: failure
    func getFailResponse(encodingError: Error, failure:@escaping (_ response: [String: Any]) -> Void) {
        print(encodingError._code)
        if encodingError._code == NSURLErrorTimedOut {
            failure([ModelKeys.ResponseKeys.message: Messages.Common.strReqTimeOut])
        } else if encodingError._code == NSURLErrorNotConnectedToInternet || encodingError._code == 404 {
            failure([ModelKeys.ResponseKeys.message: Messages.Common.internetAlertMsg])
        } else {
            failure([ModelKeys.ResponseKeys.message: encodingError.localizedDescription])
        }
    }
}

// MARK: - Rechability
extension ApiManager {
    /// reachabilityChanged
    @objc func reachabilityChanged(_ notification: Notification) {
        if let reachability = notification.object as? Reachability {
            switch reachability.connection {
            case .wifi, .cellular:
                isInternetAvailable = true
                print("Reachable via WiFi or Cellular")
            case .none:
                isInternetAvailable = false
                Constant.window?.showInternetAlert()
                print("Network not reachable")
            case .unavailable:
                isInternetAvailable = false
                Constant.window?.showInternetAlert()
            }
        } else {
            isInternetAvailable = false
            print("Network not reachable")
        }
    }
}
