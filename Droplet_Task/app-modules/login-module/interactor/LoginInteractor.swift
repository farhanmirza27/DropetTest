//
//  LoginInteractor.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

class LoginInteractor : PresenterToInteractorLoginProtocol {
 
    var presenter: InteractorToPresenterLoginProtocol?
    var firebaseManager: FirebaseManager?

    func checkUserLoggedIn() {
        firebaseManager?.checkLoggedInUser(responseHandler: { result in
            if result {
                self.presenter?.loginSuccess()
            }
        })
     }
    func verifyNumber(number: String) {
        firebaseManager?.verifyPhoneNumber(number: number, responseHandler: { verificationID in
            UserDefaults.standard.set(verificationID, forKey: "verficationID")
            self.presenter?.phoneVerifcationSucess()
        }, { error in
            self.presenter?.fail(error: error.localizedDescription)
        })
        
    }
    
    func login(code: String) {
        if let verificationID = UserDefaults.standard.value(forKey: "verficationID") {
            firebaseManager?.signIn(verificationID: "\(verificationID)", code: code, responseHandler: { result in
                self.presenter?.loginSuccess()
            }, { error in
                self.presenter?.fail(error: error.localizedDescription)
            })
        }
    }
}
