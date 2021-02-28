//
//  TimePickerVC.swift
//  4SaleNbuy
//
//  Created by Admin on 25/01/21.
//

import UIKit

@objc protocol TimePickerDelegate: NSObjectProtocol {
    func timePickerDidSelectDate(_ time: String, isFromTime: Bool)
}

class TimePickerVC: UIViewController {

    ///
    @IBOutlet weak var constraintDatePickerViewBottom: NSLayoutConstraint!
    ///
    @IBOutlet weak var timePicker: UIDatePicker!
    ///
    @IBOutlet weak var viewMain: UIView!
    
    var selectedDate = Date()
    var localeIdentifier: String = "en_US"
    var selectButtonTitle = Messages.Button.okButton
    var cancelButtonTitle = Messages.Button.cancelButton
    var datePickerType: UIDatePicker.Mode = .date
    var isFromTime = false
    
    //Delegate
    weak var delegate: TimePickerDelegate?
    
    enum DatePickerViewPosition: CGFloat {
        case up = 0
        case down = -300
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePicker()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        openAnimation()
    }
 
    func setupDatePicker() {
        timePicker.date = selectedDate
        timePicker.locale = Locale(identifier: localeIdentifier)
        timePicker.autoresizingMask = [.flexibleWidth]
        timePicker.clipsToBounds = true
        timePicker.backgroundColor = UIColor.white
        timePicker.datePickerMode = .time
        let tap = UITapGestureRecognizer(target: self, action: #selector(DatePickerVC.closerVc))
        viewMain.addGestureRecognizer(tap)
    }

    private func openAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.viewMain.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            self.viewOpenCloseAnimation(position: DatePickerViewPosition.up)
        })
    }
    
    @objc func closerVc() {
        viewOpenCloseAnimation(position: .down)
    }
    
    func viewOpenCloseAnimation(position: DatePickerViewPosition) {
        if position == .up {
            UIView.animate(withDuration: 0.2) {
                self.constraintDatePickerViewBottom.constant = position.rawValue
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.constraintDatePickerViewBottom.constant = position.rawValue
                self.view.layoutIfNeeded()
            }, completion: { (_) in
                UIView.animate(withDuration: 0.3, animations: {
                    self.viewMain.backgroundColor = UIColor.clear
                }, completion: { (_) in
                    self.dismiss(animated: false, completion: nil)
                   
                })
            })
        }
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
    //    formatter.dateFormat = "HH:mm"
        delegate?.timePickerDidSelectDate(formatter.string(from: self.timePicker.date), isFromTime: isFromTime)
        closerVc()
    }
    
    @IBAction func btnCancelAction(_ sender: Any) {
        closerVc()
    }
    
}
