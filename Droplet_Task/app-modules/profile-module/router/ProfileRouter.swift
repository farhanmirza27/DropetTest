//
//  ProfileRouter.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import UIKit

// handles routing for profile module
class ProfileRouter : PresenterToRouterProfileProtocol {
    var navigationController: UINavigationController?
    // create module
    static func createModule(navigationController : UINavigationController) -> ProfileViewController {
        let view = ProfileViewController()
        let presenter : ViewToPresenterProfileProtocol & InteractorToPresenterProfileProtocol = ProfilePresenter()
        let interactor : PresenterToInteractorProfileProtocol = ProfileInteractor()
        let router : PresenterToRouterProfileProtocol = ProfileRouter()
    
        view.presenter = presenter
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        interactor.presenter = presenter
        interactor.firebaseClient = FirebaseClient()
        router.navigationController = navigationController
        return view
    }
    // logout navigation
    func logout() {
        navigationController?.popViewController(animated: true)
    }
    
    
    
}
