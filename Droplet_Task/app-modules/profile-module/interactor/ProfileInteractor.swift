//
//  ProfileInteractor.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

class ProfileInteractor : PresenterToInteractorProfileProtocol {
 
    var firebaseManager: FirebaseManager?
    
    var presenter: InteractorToPresenterProfileProtocol?
    
    func getProfileData() {
      
        firebaseManager?.retriveUserInfo(responseHandler: { profile in
            self.presenter?.success(profile: profile)
        }, { error in
            self.presenter?.fail(error: error.localizedDescription)
        })
    }
    
    func updateProfile(profile : Profile) {
        firebaseManager?.updateProfile(profile: profile, responseHandler: { _ in
            self.presenter?.updateSucess()
        }, { error in
            self.presenter?.fail(error: error.localizedDescription)
        })
     }
     
     func logout() {
        firebaseManager?.logout(responseHandler: { sucess in
            if sucess {
                self.presenter?.logoutSucess()
            }
            else {
                self.presenter?.fail(error: "Logout failed")
            }
        })
     }
     

}
