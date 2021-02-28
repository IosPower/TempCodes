//
//  DatePickerVC.swift
//  DatepickerLearn
//
//  Created by Admin on 23/12/20.
//

import UIKit

@objc protocol DatePickerDelegate: NSObjectProtocol {
    func datePickerDidSelectDate(_ date: Date, mode: UIDatePicker.Mode)
}

class DatePickerVC: UIViewController {

    @IBOutlet weak var constraintDatePickerViewBottom: NSLayoutConstraint!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var viewMain: UIView!
    
    var maximumDate: Date?
    var minimumDate: Date?
    var selectedDate = Date()
    var localeIdentifier: String = "en_US"
    var selectButtonTitle = Messages.Button.okButton
    var cancelButtonTitle = Messages.Button.cancelButton
    var datePickerType: UIDatePicker.Mode = .date
    
    //Delegate
    weak var delegate: DatePickerDelegate?
    
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
        datePicker.date = self.selectedDate
        if self.minimumDate != nil {
            datePicker.minimumDate = minimumDate
            datePicker.maximumDate = Date().addingTimeInterval(365.0 * 24.0 * 60.0 * 60.0)
            if self.minimumDate! > self.selectedDate {
                datePicker.date = self.minimumDate!
            }
        }
        
        if self.maximumDate != nil {
            datePicker.maximumDate = Date()
        }
        datePicker.locale = Locale(identifier: localeIdentifier)
        datePicker.autoresizingMask = [.flexibleWidth]
        datePicker.clipsToBounds = true
        datePicker.backgroundColor = UIColor.white
        datePicker.datePickerMode = .date
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
        self.delegate?.datePickerDidSelectDate(self.datePicker.date, mode: datePickerType)
        closerVc()
    }
    
    @IBAction func btnCancelAction(_ sender: Any) {
        closerVc()
    }
    
}
