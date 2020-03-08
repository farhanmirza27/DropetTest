//
//  UIColor-Extensions.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 08/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

// MARK: UIColor
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    struct AppColor {
        static let defaultRed = UIColor.red
    }
    
}
