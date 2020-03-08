//
//  LoginRouter.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

// login module routing handler
class LoginRouter : PresenterToRouterLoginProtocol {
    // create module with intialization
    static func createModule() -> LoginViewController {
        let view = LoginViewController()
        let presenter : ViewToPresenterLoginProtocol & InteractorToPresenterLoginProtocol = LoginPresenter()
        let interactor : PresenterToInteractorLoginProtocol = LoginInteractor()
        let router : PresenterToRouterLoginProtocol = LoginRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        interactor.firebaseClient = FirebaseClient()
        return view
    }
    // show profile screen
    func showProfile(from : UIViewController) {
        let profileModule = ProfileRouter.createModule(navigationController: from.navigationController!)
        from.navigationController?.pushViewController(profileModule, animated: true)
    }
    
    
}
