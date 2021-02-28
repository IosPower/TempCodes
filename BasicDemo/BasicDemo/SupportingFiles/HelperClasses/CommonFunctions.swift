//
//  CommonFunctions.swift
//  BasicDemo
//
//  Created by Admin on 28/02/21.
//

import UIKit
import Kingfisher
import SwiftyJSON
class CommonFunctions: NSObject {
    class func getErrorDic(jsonData: JSON) -> [String: String] {
        var errorMessage = Messages.Common.somethingWrong
        if let message = jsonData[ModelKeys.ResponseKeys.message].string {
            errorMessage = message
        }
        return [ModelKeys.ResponseKeys.message: errorMessage]
    }
    
    class func currentTimeWithAmOrPm() -> String {
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        return df.string(from: date)
    }
    
    class func addRemoveNoRecordView(onView: UIView) {
        removeNoRecordView()
        Constant.viewNoRecord = UIView(frame: CGRect(x: onView.center.x - 150, y: onView.center.y, width: 300, height: 50))
        if let viewNoRecord = Constant.viewNoRecord {
            let yourLabel: UILabel = UILabel()
            yourLabel.frame = viewNoRecord.bounds
            yourLabel.frame.size = CGSize(width: 300, height: 30)
            yourLabel.textColor = .black
            yourLabel.textAlignment = NSTextAlignment.center
            yourLabel.text = "No Record Found"
            viewNoRecord.addSubview(yourLabel)
            onView.addSubview(viewNoRecord)
        }
    }
    
    
    /// only allow number and given character limit in textfield
    ///
    /// - Parameters:
    ///   - textField: UItextField
    ///   - range: range
    ///   - string: string to pass
    /// - Returns: return's valid or not with bool value.
    class func textFieldWithNumberAndCharacterLimit(textField: UITextField, range: NSRange, string: String, charLength: Int) -> Bool {
        let onlyNo = "0123456789"
        if string.isEmpty {
            return true
        }
        let numberFiltered = string.getFilterCharacterSet(strNumorSym: onlyNo)
        if numberFiltered == "" {
            return false
        }
        return CommonFunctions.textFieldsValidate(textField: textField, charLength: charLength, range: range, replacementString: string)
    }
    
    /// character limit of textfields set
    ///
    /// - Parameters:
    ///   - textField: current text field
    ///   - charLength: max length of textfield
    ///   - range: range of string
    ///   - string: number of characters
    /// - Returns: return true false value
    class func textFieldsValidate(textField: UITextField, charLength: Int, range: NSRange, replacementString string: String) -> Bool {
        let currentCharacterCount = textField.text?.count ?? 0
        if range.length + range.location > currentCharacterCount {
            return false
        }
        let newLength = currentCharacterCount + string.count - range.length
        return newLength <= charLength
    }
    
    class func removeNoRecordView() {
        Constant.viewNoRecord?.removeFromSuperview()
        Constant.viewNoRecord = nil
    }
    
    class func setImageWithKingfisher(imgView: UIImageView?, placeHolderImage: UIImage?, imgPath: String) {
      //  http://4saleandbuy.siddhidevelopment.com/wp-content/plugins/classifier/assets/images/
        if let url = URL(string: imgPath), let imgView = imgView {
            let processor = DownsamplingImageProcessor(size: imgView.bounds.size)
            imgView.kf.indicatorType = .activity
            imgView.kf.setImage(
                with: url,
                placeholder: placeHolderImage,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.25))], completionHandler: { result in
                        switch result {
                        case .success(let value):
                            DispatchQueue.main.async {
                                imgView.image = value.image
                            }
                            print("Kingfisher image done for: \(value.source.url?.absoluteString ?? "")")
                        case .failure(let error):
                            DispatchQueue.main.async {
                                imgView.image = placeHolderImage
                            }
                            print("Kingfisher image failed: \(error.localizedDescription)")
                        }
                    })
        } else {
            DispatchQueue.main.async {
                imgView?.image = placeHolderImage
            }
        }
            
    }
}
