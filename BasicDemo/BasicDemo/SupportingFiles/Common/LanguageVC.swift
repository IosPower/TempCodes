//
//  LanguageVC.swift
//  
//
//  Created by Admin on 31/12/20.
//

import UIKit

protocol LanguageSelectionDelegate: AnyObject {
    func languageUpdated(isUpdate: Bool)
}

class LanguageVC: UIViewController {
    
    ///
    @IBOutlet weak var lblSelectLanguage: UILabel!
    ///
    @IBOutlet weak var viewLanguageList: UIView!
    ///
    @IBOutlet weak var btnEnglish: UIButton!
    ///
    @IBOutlet weak var btnOk: UIButton!
    ///
    @IBOutlet weak var btnArabic: UIButton!
    ///
    @IBOutlet weak var imgViewEnglish: UIImageView!
    ///
    @IBOutlet weak var imgViewArabic: UIImageView!
    ///
    @IBOutlet weak var constraintViewLanguageListBottom: NSLayoutConstraint!
    ///
    weak var delegate: LanguageSelectionDelegate?
    
    enum Position: CGFloat {
        case up = 0
        case down = -300
    }
    
    private var selectedLanguage = "" {
        didSet {
            updateLanguageData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localizationAccordingToLanguage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        openAnimation()
    }
    
    func setupView() {
        viewLanguageList.roundedCornerForView(cournerNumber: 5, cornorRadius: 20)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        languageSetup()
        updateLanguageData()
    }
    
    func languageSetup() {
        selectedLanguage = PreferredLanguage.language
    }
    
    // MARK: - Helper Methods
    
    func updateLanguageData() {
        switch selectedLanguage {
        case LanguageCode.arabic.rawValue:
            imgViewArabic.image = UIImage(named: "sel_Language")
            imgViewEnglish.image = UIImage(named: "unsel_Language")
        default:
            imgViewEnglish.image = UIImage(named: "sel_Language")
            imgViewArabic.image = UIImage(named: "unsel_Language")
        }
    }
    
    private func openAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1
        }, completion: { (_) in
            self.openCloseViewWithAnimation(position: Position.up, isUpdate: false)
        })
    }
    
    private func openCloseViewWithAnimation(position: Position, isUpdate: Bool) {
        if position == .up {
            UIView.animate(withDuration: 0.3) {
                self.constraintViewLanguageListBottom.constant = position.rawValue
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.constraintViewLanguageListBottom.constant = position.rawValue
                self.view.layoutIfNeeded()
            }, completion: { (_) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.alpha = 0.0
                }, completion: { (_) in
                    self.dismiss(animated: false, completion: nil)
                    self.delegate?.languageUpdated(isUpdate: isUpdate)
                })
            })
        }
    }
    
    private func closeAnimation(isUpdate: Bool) {
        openCloseViewWithAnimation(position: Position.down, isUpdate: isUpdate)
    }
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        closeAnimation(isUpdate: false)
    }

    // MARK: - IBActions
    
    @IBAction func btnEnglishAction(_ sender: Any) {
        selectedLanguage = LanguageCode.eng.rawValue
    }
    
    @IBAction func btnArabicAction(_ sender: Any) {
        selectedLanguage = LanguageCode.arabic.rawValue
    }
    
    @IBAction func btnOkAction(_ sender: Any) {
        Constant.storage.preferedLanguage = selectedLanguage
        if PreferredLanguage.language == LanguageCode.arabic.rawValue {
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        } else {
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        closeAnimation(isUpdate: true)
    }
    
    // MARK: - Helper Methods
    
    /// localization According To Language
    func localizationAccordingToLanguage() {
        //lblSelectLanguage.text = LocalizationKeys.SelectLanguage.selectLanguageKey.localizableString()
        //btnOk.setTitle(LocalizationKeys.Common.okKey.localizableString(), for: .normal)
        //btnArabic.setTitle(LocalizationKeys.SelectLanguage.arabicKey.localizableString(), for: .normal)
    }
}
struct SelectLanguage {
    static let selectLanguageKey = "selectLanguageKey"
    static let arabicKey = "arabicKey"
}
