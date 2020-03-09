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
    let resendContainer = UIComponents.shared.container(bgColor: .clear)
    let resendBtn = UIComponents.shared.button(text: "Resend Code", backgroundColor: .clear, titleColor: .blue)
    let timerLabel = UIComponents.shared.label(text: "", alignment: .left, color: .black)
    var seconds = 60
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter?.viewDidLoad()
    }
    // setup sub-views and configurations
    func setupView() {
        navigationItem.title = "Login"
        codeTF.isHidden = true
        countryCodeTF.text = "+44"
        countryCodeTF.isEnabled = false
        resendBtn.isHidden = true
        
        fieldsContainer.addSubViews(views: countryCodeTF,phoneNumTF)
        fieldsContainer.addConstraintsWithFormat("H:|-30-[v0(70)]-8-[v1]-30-|", views: countryCodeTF,phoneNumTF)
        fieldsContainer.addConstraintsWithFormat("V:|[v0(40)]|", views: countryCodeTF)
        fieldsContainer.addConstraintsWithFormat("V:|[v0(40)]|", views: phoneNumTF)
        
        resendContainer.addSubViews(views: resendBtn,timerLabel)
        resendContainer.addConstraintsWithFormat("H:|-16-[v0]-16-[v1]-16-|", views: resendBtn,timerLabel)
        resendContainer.addConstraintsWithFormat("V:|[v0(35)]|", views: resendBtn)
        resendContainer.addConstraintsWithFormat("V:|-8-[v0]", views:  timerLabel)
        
        saveAreaView.addSubViews(views: fieldsContainer,codeTF,proceedBtn,resendContainer)
        saveAreaView.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: fieldsContainer)
        saveAreaView.addConstraintsWithFormat("H:|-70-[v0]-70-|", views: codeTF)
        saveAreaView.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: proceedBtn)
        saveAreaView.addConstraintsWithFormat("H:|-30-[v0]-30-|", views: resendContainer)
        saveAreaView.addConstraintsWithFormat("V:|-40-[v0(40)]-30-[v1(40)]-40-[v2(30)]-16-[v3(40)]", views: fieldsContainer,codeTF,resendContainer,proceedBtn)
        // add targets
        proceedBtn.addTarget(self, action: #selector(didClickLoginBtn), for: .touchUpInside)
        resendBtn.addTarget(self, action: #selector(resendCode), for: .touchUpInside)
    }
    
    // handle button click for phone verfication and login
    @objc func didClickLoginBtn(sender : UIButton) {
        self.dismissKeyboard()
        if sender.tag == 0 {
            if let text = phoneNumTF.text {
                if !text.isEmpty {
                    showSpinner()
                    // verify phone number
                    presenter?.verifyNumber(number:  countryCodeTF.text! + text)
                }
            }
        } else {
            if let code = codeTF.text {
                if !code.isEmpty {
                    // perform login
                    showSpinner()
                    self.presenter?.login(code: code)
                }
                else {
                    self.alert(message: "Please enter code received via SMS")
                }
            }
        }
    }
    // resend code
    @objc func resendCode() {
        // can be used last recieved verification id but if user change phone number then its better
        if let text = phoneNumTF.text {
            if !text.isEmpty {
                presenter?.verifyNumber(number: countryCodeTF.text! + text)
            }
            else {
                self.alert(message: "please provide phone number")
            }
        }
    }
    
    // timer for resending code button
    func runTimer() {
        resendBtn.isEnabled = false
        resendBtn.setTitleColor(.gray, for: .normal)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    // update seconds on screen
    @objc func updateCounter() {
        seconds  -= 1
        timerLabel.text = "in \(seconds)"
        if seconds == 0 {
            resendBtn.isEnabled = true
            resendBtn.setTitleColor(.blue, for: .normal)
            timerLabel.text = ""
            seconds = 60
            timer?.invalidate()
        }
    }
}
// presenter to view protocols
extension LoginViewController : PresenterToViewLoginProtocol {
    // phone verification handling
    func phoneNumberVerificationSucess() {
        DispatchQueue.main.async { [weak self] in
            self?.removeSpinner()
            self?.codeTF.isHidden = false
            self?.proceedBtn.setTitle("Login", for: .normal)
            self?.proceedBtn.tag = 1
            self?.resendBtn.isHidden = false
            self?.runTimer()
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
            self?.resendBtn.isHidden = true
            self?.timer?.invalidate()
            self?.seconds = 60
            self?.timerLabel.text = ""
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
