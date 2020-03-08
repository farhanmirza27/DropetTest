//
//  LoginPresenter.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//


import UIKit

class LoginPresenter : ViewToPresenterLoginProtocol  {
    
    weak var view: PresenterToViewLoginProtocol?
    var interactor: PresenterToInteractorLoginProtocol?
    var router: PresenterToRouterLoginProtocol?
    
    func viewDidLoad() {
        interactor?.checkUserLoggedIn()
    }
    
    func verifyNumber(number : String) {
        interactor?.verifyNumber(number : number)
    }
    
    func login(code : String) {
        interactor?.login(code: code)
    }
    
    func showProfile(from : UIViewController) {
        router?.showProfile(from: from)
    }
}


extension LoginPresenter : InteractorToPresenterLoginProtocol {
    func phoneVerifcationSucess() {
        view?.phoneNumberVerificationSucess()
    }
    
    func loginSuccess() {
        view?.loginSucess()
    }
    
    func fail(error: String) {
        view?.error(error: error)
    }
    
    
}
