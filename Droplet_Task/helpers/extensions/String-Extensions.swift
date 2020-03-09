//
//  String-Extensions.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 09/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

// valid email id
extension String {
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: self)
    }
}
