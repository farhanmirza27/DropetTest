//
//  BaseViewController.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation


import UIKit

// BaseViewController to handle to handle common functions and to handle save-area

class BaseViewController: UIViewController {
    // save area
    var saveAreaView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // loader spinner view
    var vSpinner : UIView?
    
    // Setup sub-views
    private func setupView() {
        view.addSubview(saveAreaView)
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                saveAreaView.topAnchor.constraint(equalTo: guide.topAnchor),
                saveAreaView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
                saveAreaView.leftAnchor.constraint(equalTo: guide.leftAnchor),
                saveAreaView.rightAnchor.constraint(equalTo: guide.rightAnchor),
            ])
        } else {
            NSLayoutConstraint.activate([
                saveAreaView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
                saveAreaView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
                saveAreaView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
                saveAreaView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0)
            ])
        }
    }
    
    // load view
    override func loadView() {
        super.loadView()
        view.backgroundColor = UIColor.white
        hideKeyboardWhenTappedAround()
        setupView()
    }
    
    // show spinner
    func showSpinner() {
        let spinnerView = UIView.init(frame: self.view.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai =  UIActivityIndicatorView(style: .gray)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {  [weak self] in
            spinnerView.addSubview(ai)
            self?.view.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    // remove spinner
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
    
    deinit {
        print("\(type(of: self)) deinit")
    }

}


