//
//  UITextFieldExtensions.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 08/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

extension UITextField {
    // left padding for text
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    // right padding for text
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
