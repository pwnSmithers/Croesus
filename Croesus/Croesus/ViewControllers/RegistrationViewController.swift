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

    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBOutlet weak var cofirmPassword: UITextField!

    // MARK: Actions
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
                        if let personalInformation = self.storyboard?.instantiateViewController(withIdentifier: "personal") as? PersonalInformationViewController {
                            self.present(personalInformation, animated: true, completion: nil)
                            
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

