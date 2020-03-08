//
//  LoginPresenter.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//


import UIKit

// handles communication b/w view and interactor
class LoginPresenter : ViewToPresenterLoginProtocol  {
    
    weak var view: PresenterToViewLoginProtocol?
    var interactor: PresenterToInteractorLoginProtocol?
    var router: PresenterToRouterLoginProtocol?
    
    // check user session exist
    func viewDidLoad() {
        interactor?.checkUserLoggedIn()
    }
    // verify number
    func verifyNumber(number : String) {
        interactor?.verifyNumber(number : number)
    }
    // perform login
    func login(code : String) {
        interactor?.login(code: code)
    }
   // show profile screen
    func showProfile(from : UIViewController) {
        router?.showProfile(from: from)
    }
}
// interactor to presenter protcols
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
