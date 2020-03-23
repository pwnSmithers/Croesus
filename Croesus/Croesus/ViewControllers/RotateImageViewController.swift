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
        if let image = imageToEdit.image{
            let newImage = image.rotate(radians: .pi/2)
            imageToEdit.image = newImage
        }
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
        
    }
    fileprivate func dismissScreen(image: UIImage){
        uploadPhoto(image: image)
        self.dismiss(animated: true, completion: nil)
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
                          let personalInforVC = PersonalInformationViewController()
                          personalInforVC.photoURL = stringURl
                          personalInforVC.profilePicture.image = image
                      }
                      
                  }
              }
              
          }
      }

  }
    
}
