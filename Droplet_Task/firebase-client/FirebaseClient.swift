//
//  FirebaseClient.swift
//  Droplet_Task
//
//  Created by Farhan Mirza on 06/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import FirebaseAuth
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift


typealias ResponseHandler<T> = (T) -> Void
typealias ErrorHandler = (Error) -> Void

// Firebase client protocols
protocol FirebaseClientProtocol : class {
    func checkLoggedInUser(responseHandler: @escaping ResponseHandler<Bool>)
    func signIn(verificationID : String, code : String, responseHandler:@escaping ResponseHandler<String>,_ errorHandler:@escaping ErrorHandler)
    func verifyPhoneNumber(number: String, responseHandler:@escaping ResponseHandler<String>,_ errorHandler:@escaping ErrorHandler)
    func saveProfileInfo(uid : String)
    func updateProfile(profile : Profile,responseHandler:@escaping ResponseHandler<Bool>,_ errorHandler:@escaping ErrorHandler)
    func retriveUserInfo(responseHandler:@escaping ResponseHandler<Profile>,_ errorHandler:@escaping ErrorHandler)
    func logout(responseHandler:@escaping ResponseHandler<Bool>)
}

// FirebaseClient handles all firebase requests
class FirebaseClient : FirebaseClientProtocol {
    let db = Firestore.firestore()
    // sign in with phone
    func checkLoggedInUser(responseHandler: @escaping ResponseHandler<Bool>) {
        if let _ = Auth.auth().currentUser {
            responseHandler(true)
        }
        else {
            responseHandler(false)
        }
    }
    // verify phone number
    func verifyPhoneNumber(number: String, responseHandler: @escaping ResponseHandler<String>, _ errorHandler: @escaping ErrorHandler) {
        PhoneAuthProvider.provider().verifyPhoneNumber("+44" + number, uiDelegate: nil) { (verificationID, error) in
            if let error = error {
                errorHandler(error)
            }
            if let verificationID = verificationID {
                responseHandler(verificationID)
            }
        }
    }
    // sign in with code
    func signIn(verificationID: String, code : String ,responseHandler: @escaping ResponseHandler<String>, _ errorHandler: @escaping ErrorHandler) {
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationID,
            verificationCode: code)
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                errorHandler(error)
            }
            else {
                // save new user
                self.retriveUserInfo(responseHandler: {  profile in
                    responseHandler((authResult?.user.uid)!)
                }) { error in
                    self.saveProfileInfo(uid: (authResult?.user.uid)!)
                    responseHandler((authResult?.user.uid)!)
                }
            }
        }
    }
    // save user profile information
    func saveProfileInfo(uid : String) {
        let user = Profile(firstName: "", lastName: "", phone: "", email: "", location: "", profilePicture: "")
        do {
            try db.collection("users").document(uid).setData(from: user)
        } catch let error {
            print("Error writing user to Firestore: \(error)")
            return
        }
    }
    
    // get user profile information for logged in user
    func retriveUserInfo(responseHandler: @escaping ResponseHandler<Profile>, _ errorHandler: @escaping ErrorHandler) {
        if let currentUser = Auth.auth().currentUser {
            let docRef = db.collection("users").document(currentUser.uid)
            docRef.getDocument { (document, error) in
                let result = Result {
                    try document.flatMap {
                        try $0.data(as: Profile.self)
                    }
                }
                switch result {
                case .success(let user):
                    if let user = user {
                        responseHandler(user)
                    } else {
                        errorHandler(DataError.NoRecord)
                    }
                case .failure(let error):
                    errorHandler(error)
                }
            }
        }
    }
    
     // update user profile
    func updateProfile(profile: Profile, responseHandler: @escaping ResponseHandler<Bool>, _ errorHandler: @escaping ErrorHandler) {
        
        if let currentUser = Auth.auth().currentUser {
            let userRef = db.collection("users").document(currentUser.uid)
            
            // Set the "capital" field of the city 'DC'
            let test = try! Firestore.Encoder().encode(profile)
            
            userRef.updateData(test) { err in
                if let err = err {
                    errorHandler(err)
                } else {
                    responseHandler(true)
                }
            }
        }
    }
    
    func logout(responseHandler: @escaping ResponseHandler<Bool>) {
        do {
            try Auth.auth().signOut()
            responseHandler(true)
        } catch {
           responseHandler(false)
        }
    }
    
}


// DataError
enum DataError : Error {
    case NoRecord
}
extension DataError: LocalizedError {
    public var errorDescription: String? {
        return "No record exist."
    }
}
