//
//  LoginInteractor.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

// LoginInteractor to handle backend request handling
class LoginInteractor : PresenterToInteractorLoginProtocol {
    
    var presenter: InteractorToPresenterLoginProtocol?
    var firebaseClient: FirebaseClientProtocol?
    
    // check existing user session
    func checkUserLoggedIn() {
        firebaseClient?.checkLoggedInUser(responseHandler: { result in
            if result {
                self.presenter?.loginSuccess()
            }
        })
    }
    // verify phone numnber
    func verifyNumber(number: String) {
        // internet connectivity
        guard NetworkManager.shared.connectedToNetwork() else {
            presenter?.fail(error: "you are not connected to internet")
            return
        }
        firebaseClient?.verifyPhoneNumber(number: number, responseHandler: { verificationID in
            // save verification id
            UserDefaults.standard.set(verificationID, forKey: "verficationID")
            // sucess
            self.presenter?.phoneVerifcationSucess()
        }, { error in
            // failure
            self.presenter?.fail(error: error.localizedDescription)
        })
        
    }
    // perform login with code
    func login(code: String) {
        // internet connectivity
            guard NetworkManager.shared.connectedToNetwork() else {
                presenter?.fail(error: "you are not connected to internet")
                return
            }
        if let verificationID = UserDefaults.standard.value(forKey: "verficationID") {
            firebaseClient?.signIn(verificationID: "\(verificationID)", code: code, responseHandler: { result in
                // sucess
                UserDefaults.standard.removeObject(forKey: "verficationID")
                self.presenter?.loginSuccess()
            }, { error in
                // failure
                self.presenter?.fail(error: error.localizedDescription)
            })
        }
    }
}
