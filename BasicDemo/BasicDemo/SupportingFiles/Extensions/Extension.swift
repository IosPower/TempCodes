//
//  Extension.swift
//  BasicDemo
//
//  Created by Admin on 12/02/21.
//

import UIKit

// MARK: - Window Extension
extension UIWindow {
    ///
    func showInternetAlert() {
        let alertController = UIAlertController(title: "No Internet!", message: Messages.Common.internetAlertMsg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: Messages.Button.okButton, style: UIAlertAction.Style.default) { _ in
            print("OK Pressed")
        }
        alertController.addAction(okAction)
        makeKeyAndVisible()
        rootViewController?.present(alertController, animated: true, completion: nil)
    }
}



extension UIStoryboard {
    
    // MARK: - Convenience Initializers
    /// Storyboard initializer
    ///
    /// - Parameters:
    ///   - storyboard: will set storyboard name
    ///   - bundle: will set bundle identifier
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    // MARK: - Class Functions
    ///
    ///
    /// - Parameters:
    ///   - storyboard: will set storyboard name
    ///   - bundle: will set bundle identifier
    /// - Returns: will return storyboard
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    // MARK: - View Controller Instantiation from Generics
    ///
    func instantiateViewController<T>(_ identifier: T.Type) -> T where T: UIViewController {
        let className = String(describing: identifier)
        guard let viewController = self.instantiateViewController(withIdentifier: className) as? T else {
            fatalError("Couldn't instantiate view controller with identifier \(className) ")
        }
        return viewController
    }
}

// MARK: - UIViewController Extension
///
extension UIViewController {
    /// common alert controller
    func showAlert(_ title: String = Messages.Common.appTitle, message: String, buttonTitle: String) {
        DispatchQueue.main.async { [unowned self] in
            let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    /// common alert controller
    func showAlert(_ title: String = Messages.Common.appTitle, message: String, buttonTitle: String, completion: @escaping () -> Void) {
        DispatchQueue.main.async { [unowned self] in
            let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
            let okAction = UIAlertAction(title: buttonTitle, style: .default, handler: { (_) in
                completion()
            })
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    /// common alert controller
    func showAlertWithButtonTitle(_ title: String = Messages.Common.appTitle, message: String, okButtonTitle: String = Messages.Button.okButton, cancelButtonTitle: String = Messages.Button.cancelButton, okSuccess: @escaping () -> Void, cancelSuccess: (() -> Void)? = nil) {
        DispatchQueue.main.async { [unowned self] in
            let alert: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert )
            let okAction = UIAlertAction(title: okButtonTitle, style: .default, handler: { (_) in
                okSuccess()
            })
            let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .default, handler: { (_) in
                cancelSuccess?()
            })
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showImageOption() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
        let gallery = UIAlertAction(title: "Select photo from gallery", style: .default) { (action) in
            
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                imagePicker.sourceType = .photoLibrary
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        alert.addAction(gallery)
        
        let camera = UIAlertAction(title: "Capture photo from camera", style: .default) { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                
                imagePicker.sourceType = .camera
                imagePicker.cameraCaptureMode = .photo
                imagePicker.allowsEditing = false
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        alert.addAction(camera)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(cancel)
        
        gallery.setValue(UIColor.black, forKey: "titleTextColor")
        camera.setValue(UIColor.black, forKey: "titleTextColor")
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.modalPresentationStyle = .overFullScreen
        alert.modalTransitionStyle = .crossDissolve
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension for String Methods
///
extension String {
    /// Trim string from left & right side extra spaces.
    ///
    /// - Returns: final string after removing extra left & right space.
    
    ///
    func removeWhiteSpace() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
    
    ///
    func getFilterCharacterSet(strNumorSym: String) -> String {
        let aSet = NSCharacterSet(charactersIn: strNumorSym).inverted
        let compSepByCharInSet = self.components(separatedBy: aSet)
        let numberFiltered = compSepByCharInSet.joined(separator: "")
        return numberFiltered
    }
    
    // check valid mail
    func isValidEmail() -> Bool {
        if self.isEmpty {
            return false
        }
        let emailRegEx = "[.0-9a-zA-Z_-]+@[0-9a-zA-Z.-]+\\.[a-zA-Z]{2,20}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        if !emailTest.evaluate(with: self) {
            return false
        }
        return true
    }
    
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{9,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    // check valid Password
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])[0-9a-zA-Z!@#$£€§%…^&*\\/()\\[\\]\\-_=+{}|?>.<,:;~`'\"/\\\\]{8,128}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
    }
    
    func dateFor(format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date
    }
    
    ///
    func convertDate(fromInputFormat inputFormat: String = "yyyy-MM-dd", toOutputFormat outputFormat: String = "dd MMM") -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = inputFormat//this your string date format
        guard let convertedDate = dateFormatter.date(from: self) else { return nil }
        guard dateFormatter.date(from: self) != nil else { return nil }
        dateFormatter.dateFormat =  outputFormat // 12 Jan
        let timeStamp = dateFormatter.string(from: convertedDate)
        return timeStamp
    }
    
    /// convert String to Date
    func dateOfFormat(_ format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)
    }
    
    /// from base64 to string convertion
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    /// string to base64 string
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    /// check string is numeric or not
    var isNumeric: Bool {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
    
    func localizableString() -> String {
        let languageCode = PreferredLanguage.language
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj"), let bundle = Bundle(path: path) else { return "" }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
    }
}
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

extension UIView {
     func roundedCornerForView(cournerNumber: CGFloat, cornorRadius: CGFloat ) {
        var maskPath: UIBezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.bottomLeft, .bottomRight]), cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        switch cournerNumber {
        case 1:
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .topLeft, cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        case 2:
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .topRight, cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        case 3:
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .bottomLeft, cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        case 4:
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .bottomRight, cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        case 5:
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.topLeft, .topRight]), cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        case 6:
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.topLeft, .bottomLeft]), cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        case 7:
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.bottomLeft, .bottomRight]), cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        case 8:
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.topLeft, .bottomRight]), cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        case 9:
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.bottomLeft, .topRight]), cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        case 10:
            maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: ([.topLeft, .topRight, .bottomLeft, .bottomRight]), cornerRadii: CGSize(width: cornorRadius, height: cornorRadius))
        default:
            break
        }
        let maskLayer: CAShapeLayer = CAShapeLayer()
        maskLayer.frame = bounds
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    /// roundCorners
    ///
    /// - Parameter cornerRadius: radius value
    func roundCorners(cornerRadius: CGFloat = 5.0) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        DispatchQueue.main.async {
            let path = UIBezierPath(roundedRect: self.bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
            let maskLayer = CAShapeLayer()
            maskLayer.frame = self.bounds
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
        }
    }
    
    /// This will set corner radius of View
    func roundView() {
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
    }
    
    /// borderAndCornerRadius
    ///
    /// - Parameters:
    ///   - cornerRadius: radius value
    ///   - borderWidth: border width value
    ///   - borderColor: border color
    func borderAndCornerRadius(cornerRadius: CGFloat = 10, borderWidth: CGFloat = 1, borderColor: UIColor = UIColor.gray) {
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.lightGray.cgColor
        shapeLayer.lineWidth = 1
        shapeLayer.lineDashPattern = [7, 3] // 7 is the length of dash, 3 is length of the gap.

        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
    }
    
    func makeSnapshot() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: frame.size)
            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
        } else {
            return layer.makeSnapshot()
        }
    }
}
extension CALayer {
    func makeSnapshot() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
}
