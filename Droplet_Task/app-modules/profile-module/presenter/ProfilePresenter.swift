//
//  ProfilePresenter.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation


class ProfilePresenter : ViewToPresenterProfileProtocol  {
 
   weak var view: PresenterToViewProfileProtocol?
    
    var interactor: PresenterToInteractorProfileProtocol?
    
    var router: PresenterToRouterProfileProtocol?
    
    func viewDidLoad() {
        interactor?.getProfileData()
    }
    
    func updateProfile(profile: Profile) {
        interactor?.updateProfile(profile: profile)
     }
     
     func logout() {
        interactor?.logout()
     }
     
}

extension ProfilePresenter : InteractorToPresenterProfileProtocol {
  
    func updateSucess() {
    view?.updateSucess()
    }
    
    func success(profile: Profile) {
        view?.displayProfile(profile: profile)
    }
    
    func fail(error: String) {
        view?.error(error : error)
    }
    
    func logoutSucess() {
        router?.logout()
      }
      
}
 

