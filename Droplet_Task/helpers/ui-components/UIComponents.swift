//
//  UIComponents.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

class UIComponents {
    static let shared = UIComponents()
    
    // MARK: UIButton
    func button(text: String? = nil, backgroundColor : UIColor = .black, titleColor : UIColor = .white, fontSize : CGFloat = 16) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(text, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.titleLabel?.font = UIFont(name: FontName.Medium, size: fontSize)
        button.layer.cornerRadius = 10
        return button
    }
    // MARK: UIView
    func container(bgColor : UIColor = .white, cornerRadius : CGFloat = 0) -> UIView {
        let view = UIView()
        view.backgroundColor = bgColor
        view.layer.cornerRadius = cornerRadius
        return view
    }
    // MARK: UITableView
    func tableView() -> UITableView {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableView.automaticDimension
        tableView.tableFooterView = UIView()
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }
    // MARK: UIImageView
    func imageView(name: String, contentMode : UIView.ContentMode = .scaleToFill) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: name)
        imageView.contentMode = contentMode
        return imageView
    }
    // MARK: UITextField
    func textField (placeHolder : String = "", keyboardType: UIKeyboardType = .default) -> UITextField {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.font = UIFont(name: FontName.Regular, size: 16)
        textField.borderStyle = .none
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.borderWidth = 1
        textField.keyboardType = keyboardType
        textField.setLeftPaddingPoints(20)
        textField.setRightPaddingPoints(20)
        return textField
    }
    // MARK: UILabel
       func label(text: String? = nil, alignment: NSTextAlignment = .left, color: UIColor = UIColor.black, fontName : String = FontName.Regular ,fontSize : CGFloat = 14) -> UILabel {
           let label = UILabel()
           label.text = text
           label.textColor = color
           label.textAlignment = alignment
           label.numberOfLines = 0
           label.font = UIFont(name: fontName, size: fontSize)
           return label
       }
}

