//
//  RegistrationViewController.swift
//  Croesus
//
//  Created by Smithers on 21/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//
import UIKit
import Firebase
import SWActivityIndicatorView

class RegistrationViewController: UIViewController {
    
    // MARK: Properties
    fileprivate var activityIndicatorView: SWActivityIndicatorView!
    fileprivate var blurView: UIView!
    
    // MARK: Outlets
    @IBOutlet weak var firstName: UITextField!
    
    @IBOutlet weak var lastName: UITextField!
    
    @IBOutlet weak var idNumber: UITextField!
    
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var phoneNumber: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var cofirmPassword: UITextField!
    
    @IBOutlet weak var photoImageView: UIImageView!

    // MARK: Actions
    @IBAction func uploadPhotoButton(_ sender: Any) {
        
    }
    
    @IBOutlet weak var registerButtonView: UIButton!
    
    
    @IBAction func registerButton(_ sender: Any) {
       registerUser()
    }
    // MARK: UIViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: Methods
    fileprivate func setupView(){
        registerButtonView.layer.cornerRadius = 8

    }
    func showLoadingAdded(to view: UIView) {
           if let _ = view.viewWithTag(1000) {
               return
           }
           blurView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: view.frame.height))
           blurView.tag = 1000
           blurView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
           view.addSubview(blurView)
           activityIndicatorView = SWActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
           activityIndicatorView.color = UIColor.darkGray
           activityIndicatorView.backgroundColor = .clear
           blurView.addSubview(self.activityIndicatorView)
           activityIndicatorView.center = blurView.center
           activityIndicatorView.startAnimating()
       }
       
       func hideLoading() {
           guard blurView != nil else { return }
           DispatchQueue.main.async {
               self.blurView.removeFromSuperview()
               self.activityIndicatorView.removeFromSuperview()
           }
       }
    @objc fileprivate func registerUser(){
        self.showLoadingAdded(to: self.view)
        if email.text != "", password.text != "", cofirmPassword.text != ""{
            Auth.auth().createUser(withEmail: email.text!, password: password.text!) { (user, error) in
                if error != nil {
                    self.hideLoading()
                    let actionSheet = UIAlertController(title: "Error", message: "oops, something went wrong. Please try again", preferredStyle: .alert)
                    actionSheet.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
                    self.present(actionSheet, animated: true, completion: nil)
                }else{
                    self.showLoadingAdded(to: self.view)
                    Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!) { (user, error) in
                        self.hideLoading()
                        //present first view controller
                        if let tabViewController = self.storyboard?.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
                            self.present(tabViewController, animated: true, completion: nil)
                            
                        }
                    }
                }
            }
        }else{
            self.hideLoading()
            let actionSheet = UIAlertController(title: "Error", message: "Please fill in all fields", preferredStyle: .alert)
            actionSheet.addAction(UIAlertAction(title: "Ok", style: .default, handler:nil))
            self.present(actionSheet, animated: true, completion: nil)
        }
    }
    
}
