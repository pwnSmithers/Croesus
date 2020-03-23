//
//  PersonalInformationViewController.swift
//  Croesus
//
//  Created by Smithers on 22/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SWActivityIndicatorView

class PersonalInformationViewController: UIViewController {
    
    // MARK: Properties
    fileprivate var activityIndicatorView: SWActivityIndicatorView!
    fileprivate var blurView: UIView!
    var user : User!
    var photoURL : String?
    var uid : String?
    
    // MARK: Outlets
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBAction func uploadPhoto(_ sender: Any) {
        addPhoto()
    }
    
    @IBOutlet weak var submitButtonView: UIButton!
    
    @IBAction func submitInformation(_ sender: Any) {
        sendUserData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupUserListeners()
    }
    
    fileprivate func setupView(){
        submitButtonView.layer.cornerRadius = 6
    }
    fileprivate func setupUserListeners(){
        Auth.auth().addStateDidChangeListener { auth, user in
           guard let user = user else { return }
           self.user = User(authData: user)
         }
    }
    
    fileprivate func sendUserData(){
        self.showLoadingAdded(to: self.view)
        guard let firstName = firstName.text,
            let lastname = lastName.text,
            let photoUrlString = photoURL,
            let UID = uid
        else {
            return
        }
        let userData = UserData(firstName: firstName, lastName: lastname, userEmail: self.user.email, photoUrl: photoUrlString)
        FIRFirestoreService.shared.create(for: userData, uid: UID, in: .users) { (completed) in
            if completed{
                self.hideLoading()
                self.segueToTabController()
                print("Awesome")
            }
        }
    }
    
}


extension PersonalInformationViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{

    fileprivate func addPhoto(){
        let imagePickerController = UIImagePickerController()
               imagePickerController.delegate = self

                let actionSheet = UIAlertController(title: "Photo Source", message: nil, preferredStyle: .actionSheet)
               actionSheet.popoverPresentationController?.sourceView = self.view
                actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                   if UIImagePickerController.isSourceTypeAvailable(.camera){
                       imagePickerController.sourceType = .camera
                    imagePickerController.allowsEditing = true
                       self.present(imagePickerController, animated: true, completion: nil)
                   }
                }))

                actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                    imagePickerController.sourceType = .photoLibrary
                    imagePickerController.allowsEditing = true
                   self.present(imagePickerController, animated: true, completion: nil)
                 }))

                actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                self.present(actionSheet, animated: true, completion: nil)

    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        let imageRotationVC = RotateImageViewController()
        imageRotationVC.imageToRotate = image
        picker.dismiss(animated: true, completion: nil)
        present(imageRotationVC, animated: true, completion: nil)
        //self.navigationController?.pushViewController(imageRotationVC, animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }


}
