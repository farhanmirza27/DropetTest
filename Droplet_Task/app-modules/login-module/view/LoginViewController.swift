//
//  LoginViewController.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit


class LoginViewController: BaseViewController {
    
    var presenter : ViewToPresenterLoginProtocol?
    
    let phoneNumTF = UIComponents.shared.textField(placeHolder: "Phone Number", keyboardType: .numberPad)
    let codeTF = UIComponents.shared.textField(placeHolder: "Verification Code", keyboardType: .numberPad)
    let loginBtn = UIComponents.shared.button(text: "Verify")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
        presenter?.viewDidLoad()
    }
    
    func setupView() {
        codeTF.isHidden = true
        saveAreaView.addSubViews(views: phoneNumTF,codeTF,loginBtn)
        saveAreaView.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: phoneNumTF)
        saveAreaView.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: codeTF)
        saveAreaView.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: loginBtn)
        saveAreaView.addConstraintsWithFormat("V:|-40-[v0(40)]-30-[v1(40)]-40-[v2(40)]", views: phoneNumTF,codeTF,loginBtn)
        
        loginBtn.addTarget(self, action: #selector(didClickLoginBtn), for: .touchUpInside)
    }
    
    
    @objc func didClickLoginBtn(sender : UIButton) {
        self.dismissKeyboard()
        showSpinner()
        if sender.tag == 0 {
            if let text = phoneNumTF.text {
                if !text.isEmpty {
                    presenter?.verifyNumber(number: phoneNumTF.text!)
                }
            }
        } else {
            if let code = codeTF.text {
                if !code.isEmpty {
                    self.presenter?.login(code: code)
                }
                else {
                    self.alert(message: "Please enter code received via SMS")
                }
            }
        }
    }
}

extension LoginViewController : PresenterToViewLoginProtocol {
    func phoneNumberVerificationSucess() {
        DispatchQueue.main.async {
            self.removeSpinner()
            self.codeTF.isHidden = false
            self.loginBtn.setTitle("Login", for: .normal)
            self.loginBtn.tag = 1
        }
        
    }
    
    func loginSucess() {
        DispatchQueue.main.async { [weak self] in
            self?.removeSpinner()
            self?.presenter?.showProfile(from: self!)
        }
    }
    
    func error(error: String) {
        DispatchQueue.main.async { [weak self] in
            self?.removeSpinner()
            self?.alert(message : error)
        }
        
    }
    
    
}
