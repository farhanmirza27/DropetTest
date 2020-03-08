//
//  ProfileProtocols.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

protocol ViewToPresenterProfileProtocol : class {
    var view : PresenterToViewProfileProtocol? {get set}
    var interactor : PresenterToInteractorProfileProtocol? {get set}
    var router : PresenterToRouterProfileProtocol? {get set}
    
    func viewDidLoad()
    func updateProfile(profile : Profile)
    func logout()
}

protocol PresenterToViewProfileProtocol : class {
    func displayProfile(profile : Profile)
    func updateSucess()
    func error(error : String)
}

protocol PresenterToRouterProfileProtocol : class {
    var navigationController : UINavigationController? {get set}
    static func createModule(navigationController : UINavigationController) -> ProfileViewController
    func logout()
}

protocol PresenterToInteractorProfileProtocol : class {
    var presenter : InteractorToPresenterProfileProtocol? {get set}
    var firebaseManager : FirebaseManager? {get set}
    func getProfileData()
    func updateProfile(profile : Profile)
    func logout()
}

protocol InteractorToPresenterProfileProtocol : class {
    func success(profile : Profile)
    func fail(error : String)
    func updateSucess()
    func logoutSucess()
    
}
