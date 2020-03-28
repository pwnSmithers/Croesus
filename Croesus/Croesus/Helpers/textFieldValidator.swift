//
//  textFieldValidator.swift
//  Croesus
//
//  Created by Smithers on 28/03/2020.
//  Copyright © 2020 Smithers. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func checkFields(placeholder:String){
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.red])
    }
}
