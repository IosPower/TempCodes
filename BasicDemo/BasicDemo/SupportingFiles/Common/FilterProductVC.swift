//
//  FilterProductVC.swift
//  4SaleNbuy
//
//  Created by Admin on 09/12/20.
//

import UIKit

 protocol FilterProductSelectionDelegate: AnyObject {
    func selectCategoryOrProduct(name: String, catId: Int?)
    func dismissFilterProductVC()
}

class FilterProductVC: UIViewController {
    
    // MARK: - IBOutlets
    
    ///
    @IBOutlet weak var tblView: UITableView!
    ///
    @IBOutlet weak var btnClose: UIButton!
    ///
    @IBOutlet weak var lblClose: UILabel!
    ///
    @IBOutlet weak var imgViewClose: UIImageView!

    @IBOutlet weak var constraintTableViewHeight: NSLayoutConstraint!
    ///
    @IBOutlet weak var scrollView: UIScrollView!
    ///
    @IBOutlet weak var viewTableParent: UIView!
    ///
    @IBOutlet weak var constraintButtonCloseBottom: NSLayoutConstraint!
    
    // MARK: - Variables
    
    weak var filterProductSelectionDelegate: FilterProductSelectionDelegate?
    
    var arrFilterModel: [FilterDropdownModel] = []
    
    var isHiddenBottomTab = false
    
    var isHideCount = false
    
    var selectedName =  ""
    
    // MARK: - ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        openAnimation()
    }
    
    // MARK: - Initialize
    
    func setupView() {
        tblView?.register(UINib(nibName: "FilterProductPopupTableViewCell", bundle: nil), forCellReuseIdentifier: "FilterProductPopupTableViewCell")
        let tabBarHeight = TabbarService.shared.tabBarController.getHeight()
        let gap: CGFloat = isHiddenBottomTab == false ? (tabBarHeight - Constant.bottomSafeAreaHeight) : 0
        constraintButtonCloseBottom.constant = (20 + gap)
        
        tblView.borderAndCornerRadius(cornerRadius: 10, borderWidth: 0, borderColor: .clear)
        scrollView.borderAndCornerRadius(cornerRadius: 10, borderWidth: 0, borderColor: .clear)
        
        updateNameAccordingToLanguage()
    }
    
    // MARK: - IBActions
    
    ///
    @IBAction func btnCloseAction(_ sender: Any) {
        closeAnimation()
    }
    
    // MARK: - Helper Methods
    
    private func openAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.alpha = 1
        }, completion: { (_) in
            self.updateTableViewHeightWithAnimation(heightValue: CGFloat(55 * self.arrFilterModel.count))
        })
    }
    
    func updateTableViewHeightWithAnimation(heightValue: CGFloat) {
        if heightValue > 0 {
            UIView.animate(withDuration: 0.3) {
                self.constraintTableViewHeight.constant = heightValue
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.constraintTableViewHeight.constant = 0
                self.view.layoutIfNeeded()
            }, completion: { (_) in
                UIView.animate(withDuration: 0.2, animations: {
                    self.view.alpha = 0.0
                }, completion: { (_) in
                    self.dismiss(animated: false, completion: nil)
                    self.filterProductSelectionDelegate?.dismissFilterProductVC()
                })
            })
        }
    }
    
    func closeAnimation() {
        self.updateTableViewHeightWithAnimation(heightValue: 0)
    }
    
    // MARK: - Helper Methods
    
    /// update label according to language
    /// - Parameter languageCode: languageCode for localization
    func updateNameAccordingToLanguage() {
        lblClose.text = LocalizationKeys.FilterProduct.closeKey.localizableString()
    }
}

// MARK: - UICollectionViewDataSource
extension FilterProductVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilterModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterProductPopupTableViewCell", for: indexPath) as? FilterProductPopupTableViewCell else { return UITableViewCell() }
        
        let name = arrFilterModel[indexPath.row].name
        
        cell.lblProductName.text = name
        
        if selectedName == name {
            cell.lblProductName.textColor = UIColor.appRed
        } 
       
//        if indexPath.row == 0 && isHideCount {
//            cell.lblProductName.textColor = UIColor.appRed
//        }
        
        if isHideCount {
            cell.lblProductCount.text = ""
        } else {
            cell.lblProductCount.text = "\(arrFilterModel[indexPath.row].count)"
        }
        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension FilterProductVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closeAnimation()
        let name = arrFilterModel[indexPath.row].name
        let catId = arrFilterModel[indexPath.row].cat_id
        
        filterProductSelectionDelegate?.selectCategoryOrProduct(name: name, catId: catId)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
}
