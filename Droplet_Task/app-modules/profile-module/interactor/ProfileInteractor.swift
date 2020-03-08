//
//  ProfileInteractor.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

// ProfileInteractor to handle backend request handling
class ProfileInteractor : PresenterToInteractorProfileProtocol {
    var firebaseClient : FirebaseClient?
    var presenter: InteractorToPresenterProfileProtocol?
    
    // get logged in user profile data
    func getProfileData() {
        firebaseClient?.retriveUserInfo(responseHandler: { profile in
            self.presenter?.success(profile: profile)
        }, { error in
            self.presenter?.fail(error: error.localizedDescription)
        })
    }
    // update profile
    func updateProfile(profile : Profile) {
        firebaseClient?.updateProfile(profile: profile, responseHandler: { _ in
            self.presenter?.updateSucess()
        }, { error in
            self.presenter?.fail(error: error.localizedDescription)
        })
     }
     // handle logout
     func logout() {
        firebaseClient?.logout(responseHandler: { sucess in
            if sucess {
                self.presenter?.logoutSucess()
            }
            else {
                self.presenter?.fail(error: "Logout failed")
            }
        })
     }
     

}
