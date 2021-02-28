//
//  ViewController.swift
//  BasicDemo
//
//  Created by Admin on 12/02/21.
//

import UIKit

struct dadd {
    let a: String
    let b: String
}

class ViewController: UIViewController {
    
    var strFromTime = ""
    
    var strSelectedDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sparkAndWidth(arrSpark: [9, 2, 4, 3, 5, 6, 2, 4, 4, 1], sparkWidth: 10)
        print("start")
        DispatchQueue.main.async {
            print("ankit")
            DispatchQueue.main.async {
                print("ankit")
                
                DispatchQueue.global().sync {
                    print("ravi")
                }
                
                print("fff")
                
            }
            
            print("piyush")
        }
        print("end")
        
        // LocalizationKeys.MyListings.myListingTitleKey.localizableString()
    }
    
    
    
    func sparkAndWidth(arrSpark: [Int], sparkWidth: Int) {
        
        var lastValue = ""
        
        var strWow = ""
        
        for (index, sparkValue) in arrSpark.enumerated() {
            
            let result = "X" + String(repeating: "~", count: sparkValue)
            strWow += result
            
            if strWow.count <= sparkWidth {
                lastValue = strWow
                
                if index == (arrSpark.count - 1) {
                    print(lastValue + String(repeating: "0", count: (sparkWidth - lastValue.count)))
                }
                
            } else {
                let newwCount = strWow.count - result.count
                
                print(lastValue + String(repeating: "0", count: (sparkWidth - newwCount)))
                
                strWow = result
                
                lastValue = strWow
                
                if index == (arrSpark.count - 1) {
                    print(lastValue + String(repeating: "0", count: (sparkWidth - lastValue.count)))
                }
            }
        }
    }
    
    func openTimePicker() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(TimePickerVC.self)
        vc.modalPresentationStyle = .overFullScreen
        vc.selectButtonTitle = "Ok"
        vc.cancelButtonTitle = "Cancel"
        vc.isFromTime = true
        vc.datePickerType = .time
        
        if strFromTime != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            //dateFormatter.dateFormat = "HH:mm"
            if let date = dateFormatter.date(from: strFromTime) {
                vc.selectedDate = date
            }
        }
        
        vc.delegate = self
        present(vc, animated: false, completion: nil)
    }
    
    func openDatePicker() {
        let vc = UIStoryboard.storyboard(.main).instantiateViewController(DatePickerVC.self)
        vc.modalPresentationStyle = .overFullScreen

        vc.selectButtonTitle = "Ok"
        vc.cancelButtonTitle = "Cancel"
        vc.maximumDate = Date()
        vc.datePickerType = .date
        
        var components = DateComponents()
        components.year = -100
        let minDate = Calendar.current.date(byAdding: components, to: Date())
        
        if strSelectedDate != "" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM, yyyy"
            if let date = dateFormatter.date(from: strSelectedDate) {
                if let newDate = dateFormatter.string(from: date).dateFor(format: "dd MMMM, yyyy") {
                    vc.selectedDate = newDate
                }
            }
        }
        vc.minimumDate = minDate
        vc.delegate = self

        present(vc, animated: false, completion: nil)
    }
    
    func openLanguage() {
        let languageVC = UIStoryboard.storyboard(.main).instantiateViewController(LanguageVC.self)
        languageVC.delegate = self
        languageVC.modalPresentationStyle = .overFullScreen
        present(languageVC, animated: false, completion: nil)
    }
    
    func openHomeWithTabbarList()  {
       // let tabbarController = TabbarService.shared.getTabbarController(selectedIndex: 0)
       // self.navigationController?.pushViewController(tabbarController, animated: true)
    }
}

// MARK: - DatePickerDelegate
extension ViewController: TimePickerDelegate {
    func timePickerDidSelectDate(_ time: String, isFromTime: Bool) {
        if isFromTime {
            strFromTime = time
        } else {
            
        }
    }
}
// MARK: - DatePickerDelegate
extension ViewController: DatePickerDelegate {
    func datePickerDidSelectDate(_ date: Date, mode: UIDatePicker.Mode) {
        if mode == .date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
            strSelectedDate = convertDateFormat(strDate: formatter.string(from: date))
           // txtDateOfBirth.text = strSelectedDate
        }
    }
    func convertDateFormat(strDate: String) -> String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd MMMM, yyyy"
        
        guard let date = dateFormatterGet.date(from: strDate) else { return "" }
        return dateFormatterPrint.string(from: date)
    }
}
extension ViewController: LanguageSelectionDelegate {
    func languageUpdated(isUpdate: Bool) {
        if isUpdate {
            self.viewWillAppear(true)
            let window = UIApplication.shared.delegate?.window
            if let nav: UINavigationController = UIStoryboard.storyboard(.main).instantiateViewController(withIdentifier: "rootNav") as? UINavigationController {
              //  let tabbarController = TabbarService.shared.getTabbarController(selectedIndex: 4)
              //  nav.viewControllers = [tabbarController]
                window??.rootViewController = nav
            }
        }
    }
}

