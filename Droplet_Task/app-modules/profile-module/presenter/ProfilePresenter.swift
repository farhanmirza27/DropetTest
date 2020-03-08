//
//  ProfilePresenter.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

// handles communication b/w view and interactor
class ProfilePresenter : ViewToPresenterProfileProtocol  {
    
    weak var view: PresenterToViewProfileProtocol?
    var interactor: PresenterToInteractorProfileProtocol?
    var router: PresenterToRouterProfileProtocol?
    
    // view did load
    func viewDidLoad() {
        interactor?.getProfileData()
    }
    // update profile
    func updateProfile(profile: Profile) {
        interactor?.updateProfile(profile: profile)
    }
    // logout
    func logout() {
        interactor?.logout()
    }
    
}
// interactor to presenter
extension ProfilePresenter : InteractorToPresenterProfileProtocol {
    // update sucess
    func updateSucess() {
        view?.updateSucess()
    }
    // data fetch sucess
    func success(profile: Profile) {
        view?.displayProfile(profile: profile)
    }
    // handle fail
    func fail(error: String) {
        view?.error(error : error)
    }
    // logout
    func logoutSucess() {
        router?.logout()
    }
    
}


