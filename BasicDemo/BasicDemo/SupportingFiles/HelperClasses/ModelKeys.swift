//
//  ModelKeys.swift
//  BasicDemo
//
//  Created by Admin on 12/02/21.
//

import UIKit

/// useful keys
class ModelKeys: NSObject {
    
    /// response keys
    struct ResponseKeys {
        static let status = "status"
        static let result = "result"
        static let message = "message"
        static let code = "code"
        static let error = "error"
        static let data = "data"
        static let total_counts = "total_counts"
        static let total_pages = "total_pages"
    }
    
    ///
    struct ApiHeaderKeys {
        static let contentType = "Content-Type"
        static let applicationOrJson = "application/json"
        static let applicationContentType = "application/x-www-form-urlencoded"
        static let multipartOrFormData = "multipart/form-data"
        static let token = "x-access-token"
        static let apikey = "apikey"
        static let accessToken = "accessToken"
    }
    
    ///
    struct MimeType {
        static let png = "image/png"
        static let jpg = "image/jpg"
        static let m4a = "audio/m4a"
        static let videoMp4 = "video/mp4"
    }
}
