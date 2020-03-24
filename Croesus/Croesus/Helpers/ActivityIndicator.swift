//
//  ActivityIndicator.swift
//  Croesus
//
//  Created by Smithers on 23/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import UIKit
import SWActivityIndicatorView

fileprivate var activityIndicatorView: SWActivityIndicatorView!
fileprivate var blurView: UIView!

extension UIViewController{
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
           blurView.addSubview(activityIndicatorView)
           activityIndicatorView.center = blurView.center
           activityIndicatorView.startAnimating()
       }
       
       func hideLoading() {
           guard blurView != nil else { return }
           DispatchQueue.main.async {
               blurView.removeFromSuperview()
               activityIndicatorView.removeFromSuperview()
           }
       }
    
    
}
