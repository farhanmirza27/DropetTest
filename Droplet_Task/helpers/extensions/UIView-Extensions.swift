//
//  Extensions.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//



import UIKit

// MARK: UIView
extension UIView {
    func addConstraintsWithFormat(_ format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
    // add subviews with variadic parameter
    func addSubViews(views : UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
    // center horizontally
    func centerHorizontally(toView : UIView) {
        self.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
    }
    // center vertically
    func centerVertically(toView : UIView) {
        self.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
    }
}

