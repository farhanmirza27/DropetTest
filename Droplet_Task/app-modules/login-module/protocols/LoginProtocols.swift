//
//  LoginProtocols.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//


import UIKit

// login module business logic

// view to presenter protocols
protocol ViewToPresenterLoginProtocol : class {
    var view : PresenterToViewLoginProtocol? {get set}
    var interactor : PresenterToInteractorLoginProtocol? {get set}
    var router : PresenterToRouterLoginProtocol? {get set}
    
    func viewDidLoad() 
    func verifyNumber(number : String)
    func login(code : String)
    func showProfile(from : UIViewController)
}
// presenter to view protocols
protocol PresenterToViewLoginProtocol : class {
    func phoneNumberVerificationSucess()
    func loginSucess()
    func error(error : String)
}
// presenter to router protocols
protocol PresenterToRouterLoginProtocol : class {
    static func createModule() -> LoginViewController
    func showProfile(from : UIViewController)
}
// presenter to interactor protocols
protocol PresenterToInteractorLoginProtocol : class {
    var presenter : InteractorToPresenterLoginProtocol? {get set}
    var firebaseClient : FirebaseClientProtocol? {get set}
    func checkUserLoggedIn()
    func verifyNumber(number : String)
    func login(code : String)
}
// interactor to presenter
protocol InteractorToPresenterLoginProtocol : class {
    func phoneVerifcationSucess()
    func loginSuccess()
    func fail(error : String)
    
}
