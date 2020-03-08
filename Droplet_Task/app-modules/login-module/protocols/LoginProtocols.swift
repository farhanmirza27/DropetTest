//
//  LoginProtocols.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//


import UIKit


protocol ViewToPresenterLoginProtocol : class {
    var view : PresenterToViewLoginProtocol? {get set}
    var interactor : PresenterToInteractorLoginProtocol? {get set}
    var router : PresenterToRouterLoginProtocol? {get set}
    
    func viewDidLoad() 
    func verifyNumber(number : String)
    func login(code : String)
    func showProfile(from : UIViewController)
}

protocol PresenterToViewLoginProtocol : class {
    func phoneNumberVerificationSucess()
    func loginSucess()
    func error(error : String)
}

protocol PresenterToRouterLoginProtocol : class {
    static func createModule() -> LoginViewController
    func showProfile(from : UIViewController)
}

protocol PresenterToInteractorLoginProtocol : class {
    var presenter : InteractorToPresenterLoginProtocol? {get set}
    var firebaseManager : FirebaseManager? {get set}
    func checkUserLoggedIn()
    func verifyNumber(number : String)
    func login(code : String)
}

protocol InteractorToPresenterLoginProtocol : class {
    func phoneVerifcationSucess()
    func loginSuccess()
    func fail(error : String)
    
}
