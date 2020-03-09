//
//  LoginViewController.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

// LoginViewController for login screen
class LoginViewController: BaseViewController {
    // presenter
    var presenter : ViewToPresenterLoginProtocol?
    // sub-views
    let fieldsContainer = UIComponents.shared.container(bgColor: .clear)
    let countryCodeTF = UIComponents.shared.textField(placeHolder: "", keyboardType: .numberPad)
    let phoneNumTF = UIComponents.shared.textField(placeHolder: "Phone Number", keyboardType: .numberPad)
    let codeTF = UIComponents.shared.textField(placeHolder: "Verification Code", keyboardType: .numberPad)
    let proceedBtn = UIComponents.shared.button(text: "Verify")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    // setup sub-views and configurations
    func setupView() {
        codeTF.isHidden = true
        countryCodeTF.text = "+44"
        countryCodeTF.isEnabled = false
        
        fieldsContainer.addSubViews(views: countryCodeTF,phoneNumTF)
        fieldsContainer.addConstraintsWithFormat("H:|-30-[v0(70)]-8-[v1]-30-|", views: countryCodeTF,phoneNumTF)
        fieldsContainer.addConstraintsWithFormat("V:|[v0(40)]|", views: countryCodeTF)
        fieldsContainer.addConstraintsWithFormat("V:|[v0(40)]|", views: phoneNumTF)
        
        saveAreaView.addSubViews(views: fieldsContainer,codeTF,proceedBtn)
        saveAreaView.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: fieldsContainer)
        saveAreaView.addConstraintsWithFormat("H:|-70-[v0]-70-|", views: codeTF)
        saveAreaView.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: proceedBtn)
        saveAreaView.addConstraintsWithFormat("V:|-40-[v0(40)]-30-[v1(40)]-40-[v2(40)]", views: fieldsContainer,codeTF,proceedBtn)
        // add targets
        proceedBtn.addTarget(self, action: #selector(didClickLoginBtn), for: .touchUpInside)
    }
    
    // handle button click for phone verfication and login
    @objc func didClickLoginBtn(sender : UIButton) {
        self.dismissKeyboard()
        showSpinner()
        if sender.tag == 0 {
            if let text = phoneNumTF.text {
                if !text.isEmpty {
                    // verify phone number
                    presenter?.verifyNumber(number: phoneNumTF.text!)
                }
            }
        } else {
            if let code = codeTF.text {
                if !code.isEmpty {
                    // perform login
                    self.presenter?.login(code: code)
                }
                else {
                    self.alert(message: "Please enter code received via SMS")
                }
            }
        }
    }
}
// presenter to view protocols
extension LoginViewController : PresenterToViewLoginProtocol {
    // phone verification handling
    func phoneNumberVerificationSucess() {
        DispatchQueue.main.async {
            self.removeSpinner()
            self.codeTF.isHidden = false
            self.proceedBtn.setTitle("Login", for: .normal)
            self.proceedBtn.tag = 1
        }
        
    }
    // login success handling
    func loginSucess() {
        DispatchQueue.main.async { [weak self] in
            self?.removeSpinner()
            // clear text fields
            self?.phoneNumTF.text = nil
            self?.codeTF.text = nil
            self?.codeTF.isHidden = true
            self?.presenter?.showProfile(from: self!)
        }
    }
    // error handling
    func error(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.removeSpinner()
            self?.alert(message : error)
        }
        
    }
    
    
}
