//
//  HomeVC.swift
//  BasicDemo
//
//  Created by Admin on 28/02/21.
//

import UIKit
import AVFoundation
import AVKit
import MobileCoreServices
class HomeVC: UIViewController {

    ///
    @IBOutlet var collectionViewListingPhotos: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnUploadPhoto(sender: AnyObject) {
        
        //Create the AlertController
        let actionSheetController: UIAlertController = UIAlertController(title: "Select Photo", message: "", preferredStyle: .actionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Photo", style: .default)
        { action -> Void in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera;
                imagePicker.allowsEditing = false
                imagePicker.showsCameraControls = true
                imagePicker.mediaTypes = [kUTTypeImage as String]
                self.present(imagePicker, animated: true, completion: nil)
            }
            
        }
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose Photo", style: .default)
        { action -> Void in
            
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
                imagePicker.allowsEditing = true
                imagePicker.mediaTypes = [kUTTypeImage as String]
                self.present(imagePicker, animated: true, completion: nil)
            }
        }
        
        actionSheetController.addAction(choosePictureAction)
        
        //We need to provide a popover sourceView when using it on iPad
        actionSheetController.popoverPresentationController?.sourceView = sender as? UIView
        
        //Present the AlertController
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    
    func upsideDown(_ int : Int)
    {
        for i in 0...int
        {
            print(String.init(repeating: "*", count: int-i))
        }
        
        //        ********
        //        *******
        //        ******
        //        *****
        //        ****
        //        ***
        //        **
        //        *
    }
    
    func numberMiddle(numberOfRow: Int) {

               var no = 1
               for i in 1..<numberOfRow {
                   for _ in 1..<(numberOfRow-i) {
                       print(" ", terminator: " ")
                   }
                   for j in 1...i {
                       print("\(j)", terminator: " ")
                       no = j
                   }
                   for _ in 1..<no {
                       no -= 1
                       print("\(no)", terminator: " ")
                   }
                   print(" ")
               }
        
//                    1
//                  1 2 1
//                1 2 3 2 1
//              1 2 3 4 3 2 1
//            1 2 3 4 5 4 3 2 1
//          1 2 3 4 5 6 5 4 3 2 1
//        1 2 3 4 5 6 7 6 5 4 3 2 1
    }
    
    func starprintTraingle(_ int : Int)
    {
        for i in 1...int
        {
            print(String(repeating: " ", count: i - 1) + String(repeating: "*", count: (int+1) - i) + String(repeating: "*", count: int - i))
            
            //       ***************
            //        *************
            //         ***********
            //          *********
            //           *******
            //            *****
            //             ***
            //              *
        }
        
        for i in 1...int
        {
            print(String(repeating: " ", count: int - i) + String(repeating: "*", count: i))
            
            //                   *
            //                  **
            //                 ***
            //                ****
            //               *****
            //              ******
            //             *******
            //            ********
            
        }
        
        for i in 1...int
        {
          //  print(String(repeating: " ", count: int - i) + String(repeating: "*", count: i) + String(repeating: "*", count: i-1))
            
           print(String(repeating: " ", count: int - i) + String(repeating: "\(i)", count: i*2 - 1))
//                   *
//                  ***
//                 *****
//                *******
//               *********
//              ***********
//             *************
//            ***************
        }
//        https://awesomelyswift.blogspot.com/2019/01/programs-to-print-different-patterns-in.html
        for index in 1...int {
            var strnew = ""
            strnew = String(repeating: " ", count: int-index)
            
            
            
            for j in 1...(2 * index - 1) {
                strnew = strnew + String(repeating: "\(j)", count: 1)
            }
            print(strnew)
        }
        
       
            
    }
    
//    // MARK: -   ImagePicker Method
//
//   func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]){
//       let image = info[UIImagePickerControllerOriginalImage] as! UIImage
//       imgviewProfile.image = image
//
//      // _ = info[UIImagePickerControllerEditedImage] as! UIImage
//       let imageData = UIImagePNGRepresentation(image)! as NSData
//
//       //save in photo album
//     //  UIImageWriteToSavedPhotosAlbum(image, self, #selector(RegisterViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
//
//       //save in documents
//       let documentsPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).last
//
//       let filePath = (documentsPath! as NSString).stringByAppendingPathComponent("pic.png")
//       imageData.writeToFile(filePath, atomically: true)
//
//       self.dismissViewControllerAnimated(true, completion: nil)
//   }
//
//   func imagePickerControllerDidCancel(picker: UIImagePickerController){
//       self.dismissViewControllerAnimated(true, completion: nil)
//   }
//
//   func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo: UnsafePointer<()>){
//       if(error != nil){
//           print("ERROR IMAGE \(error.debugDescription)")
//       }
//   }
   
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
/*
// MARK: - UICollectionViewDataSource
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewListingPhotos {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CommonImageCVC", for: indexPath) as? CommonImageCVC else { fatalError("Cell not exists in storyboard") }
            let modelMedia = draftViewModel.myListingsModel?.arrMediaModel[indexPath.row]
            let imgDefault = UIImage(named: "img_category_placeholder")
          
            if let modelMedia = modelMedia {
                if !modelMedia.strUrl.isEmpty {
                    if modelMedia.isImage {
                        cell.btnVideoPlayOrPause.isHidden = true
                        CommonFunctions.setImageWithKingfisher(imgView: cell.imgView, placeHolderImage: imgDefault, imgPath: modelMedia.strUrl)
                    } else {
                        cell.setVideoThumb(videoUrl: modelMedia.strUrl)
                    }
                } else {
                    cell.btnVideoPlayOrPause.isHidden = true
                    cell.imgView.image = imgDefault
                }
            }
       
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == collectionViewListingPhotos {
            return draftViewModel.myListingsModel?.arrMediaModel.count ?? 0
        } else {
            return 0
        }
    }
}
 */

/*
// MARK: - UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
    ///
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == collectionViewListingPhotos {
            let modelMedia = draftViewModel.myListingsModel?.arrMediaModel[indexPath.row]
            if let modelMedia = modelMedia {
                if !modelMedia.strUrl.isEmpty {
                    if modelMedia.isImage {
                        let imageZoomVC = UIStoryboard.storyboard(.main).instantiateViewController(ImageZoomVC.self)
                        self.hidesBottomBarWhenPushed = true
                        imageZoomVC.arrImages = draftViewModel.myListingsModel?.arrMediaModel ?? []
                        imageZoomVC.strSelectedImage = modelMedia.strUrl
                        navigationController?.pushViewController(imageZoomVC, animated: true)
                    } else {
                        let videoURL = URL(string: modelMedia.strUrl)
                        if let url = videoURL {
                            let player = AVPlayer(url: url)
                            let avpController = AVPlayerViewController()
                            avpController.player = player
                            avpController.view.frame = self.view.frame
                            self.present(avpController, animated: true) {
                                avpController.player?.play()
                            }
                        }
                    }
                }
            }
        }
    }
}
*/

/*
// MARK: - UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegateFlowLayout {
    ///
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == collectionViewListingPhotos {
            return CGSize(width: (collectionViewListingPhotos.frame.size.width), height: (collectionViewListingPhotos.frame.size.height))
        }
        let cellWidth = (collectionView.frame.size.width * 0.8)
        return CGSize(width: cellWidth, height: collectionView.frame.size.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2

        pageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == collectionViewListingPhotos {
            return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
*/


// MARK: - UIImagePickerControllerDelegate
extension HomeVC: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        
        if let image = info[.editedImage] as? UIImage {
            //imgViewProfile.image = image
           // imgViewProfileBackground.image = image
        } else {
            if let originalImg = info[.originalImage] as? UIImage {
             //   imgViewProfile.image = originalImg
             //   imgViewProfileBackground.image = originalImg
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

