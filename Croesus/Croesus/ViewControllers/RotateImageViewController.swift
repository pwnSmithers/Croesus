//
//  RotateImageViewController.swift
//  Croesus
//
//  Created by Smithers on 23/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class RotateImageViewController: UIViewController {
    var imageToRotate : UIImage?

    @IBOutlet weak var imageToEdit: UIImageView!
    
    @IBOutlet weak var rotateButtonView: UIButton!
    
    @IBAction func rotateButton(_ sender: Any) {
        guard let image = imageToEdit.image else {
            return
        }
        rotateImage(image: image)
    }
    @IBAction func doneButton(_ sender: Any) {
        dismissScreen(image: imageToEdit.image!)
    }
    
    @IBOutlet weak var doneButtonView: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
 
    fileprivate func setupView(){
        rotateButtonView.layer.cornerRadius = 6
        doneButtonView.layer.cornerRadius = 6
        imageToEdit.image = imageToRotate
    }
    
    fileprivate func rotateImage(image: UIImage){
         let newImage = image.rotate(radians: .pi/2)
         imageToEdit.image = newImage
    }
    fileprivate func dismissScreen(image: UIImage){
        uploadPhoto(image: image)
    }
    
 fileprivate func uploadPhoto(image: UIImage){
      self.showLoadingAdded(to: self.view)
      let data = image.jpegData(compressionQuality: 0.2)
      let imageName = UUID().uuidString
      let imageReference = Storage.storage().reference().child("\(imageName).png")
      if let imageData = data{
          imageReference.putData(imageData, metadata: nil) { (metaData, error) in
              self.hideLoading()
              if error != nil{
                  print(error)
              }else{
                  imageReference.downloadURL { (url, error) in
                      if let stringURl = url?.absoluteString{
                        let imageDataDic : [String:UIImage] = ["image":image]
                        let urlDataDic : [String:String] = ["photourl":stringURl]
                        let profilePicKey = Notification.Name(rawValue: profileImageNotificationKey)
                        let profilePicUrlKey = Notification.Name(rawValue: profilePicURLNotificationKey)
                        NotificationCenter.default.post(name: profilePicKey, object: nil, userInfo: imageDataDic)
                        NotificationCenter.default.post(name: profilePicUrlKey, object: nil, userInfo: urlDataDic)
                        self.dismiss(animated: true, completion: nil)
                      }
                      
                  }
              }
              
          }
      }

  }
    
}
