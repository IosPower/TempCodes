//
//  ImageZoomVC.swift
//  4SaleNbuy
//
//  Created by Admin on 30/01/21.
//

import UIKit
import Kingfisher
class ImageZoomVC: UIViewController {

    // MARK: - IBOutlets
    
    ///
    @IBOutlet weak var collectionViewImages: UICollectionView!
    
    // MARK: - Variables
    
    var arrImages: [MediaModel] = []
    
    var strSelectedImage = ""
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let filter = arrImages.filter({$0.isImage})
        arrImages = filter
        collectionViewImages.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let index = arrImages.firstIndex(where: {$0.strUrl == strSelectedImage}) {
            DispatchQueue.main.async {
                self.collectionViewImages.scrollToItem(at: IndexPath(item: index, section: 0), at: .centeredVertically, animated: false)
            }
        }
    }
    
    // MARK: - Actions From Cell
    @objc func btnCloseActionFromCell() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func btnShareActionFromCell(sender: UIButton) {
        let indexpath = IndexPath(item: sender.tag, section: 0)
        if let cell = collectionViewImages.cellForItem(at: indexpath) as? ImageZoomCollectionViewCell {
            DispatchQueue.main.async {
                self.sharePhoto(receiptPhoto: cell.imageView.image)
            }
        }
    }
    
    @objc func btnSaveImageActionFromCell(sender: UIButton) {
        let indexpath = IndexPath(item: sender.tag, section: 0)
        if let cell = collectionViewImages.cellForItem(at: indexpath) as? ImageZoomCollectionViewCell, let img = cell.imageView.image {
            DispatchQueue.main.async {
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: img, vc: self)
                //self.sharePhoto(receiptPhoto: img)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    /// share payment receipt photo
    func sharePhoto(receiptPhoto: UIImage?) {
        // image to share
        guard let image = receiptPhoto else { return }
        
        // set up activity view controller
        let imageToShare = [image]
        
        //
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        activityViewController.popoverPresentationController?.permittedArrowDirections = []
        
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
       
        // present the view controller
        present(activityViewController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension ImageZoomVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageZoomCollectionViewCell", for: indexPath) as? ImageZoomCollectionViewCell else { fatalError("Cell not exists in storyboard") }
      //  CommonFunctions.setImageWithKingfisher(imgView: cell.imgView, placeHolderImage: nil, imgPath: arrImages[indexPath.row])
        
        cell.imageView.zoomMode = .fit
        cell.imageView.backgroundColor = .black
        cell.imageView.delegateZoomImage = self
        if let url = URL.init(string: arrImages[indexPath.row].strUrl) {
            let resource = ImageResource(downloadURL: url)
            KingfisherManager.shared.retrieveImage(with: resource, options: nil, progressBlock: nil) { result in
                switch result {
                case .success(let value):
                    print("Image: \(value.image). Got from: \(value.cacheType)")
                    cell.imageView.image = value.image
                case .failure(let error):
                    print("Error: \(error)")
                    cell.imageView.image = nil
                }
            }
        }
        
        cell.btnClose.addTarget(self, action: #selector(btnCloseActionFromCell), for: .touchUpInside)
        
        cell.btnShare.tag = indexPath.row
        cell.btnShare.addTarget(self, action: #selector(btnShareActionFromCell), for: .touchUpInside)
        
        cell.btnSaveImage.tag = indexPath.row
        cell.btnSaveImage.addTarget(self, action: #selector(btnSaveImageActionFromCell), for: .touchUpInside)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrImages.count
    }
}

// MARK: - UICollectionViewDelegate
extension ImageZoomVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ImageZoomVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewImages.frame.width, height: collectionViewImages.frame.size.height)
    }
}

// MARK: - ZoomScrollDelegate
extension ImageZoomVC: ZoomScrollDelegate {
    func scrollDidScroll(scrollView: UIScrollView) {
        print(scrollView.contentOffset)
        if scrollView.contentSize.width > collectionViewImages.frame.size.width {
            collectionViewImages.isScrollEnabled = false
        } else {
            collectionViewImages.isScrollEnabled = true
        }
    }
}
