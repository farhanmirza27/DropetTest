//
//  File.swift
//  Droplet_TaskTests
//
//  Created by Farhan Mirza on 08/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

@testable import Droplet_Task


class MockedFirebaseClient : FirebaseClientProtocol {
     
     var userLoggedIn = false
     var verifyNumberSucess = false
     var loginSucess = false
     
     
     func checkLoggedInUser(responseHandler: @escaping ResponseHandler<Bool>) {
         userLoggedIn = true
     }
     
     func signIn(verificationID: String, code: String, responseHandler: @escaping ResponseHandler<String>, _ errorHandler: @escaping ErrorHandler) {
         loginSucess = true
     }
     
     func verifyPhoneNumber(number: String, responseHandler: @escaping ResponseHandler<String>, _ errorHandler: @escaping ErrorHandler) {
         verifyNumberSucess = true
     }
     
     func saveProfileInfo(uid: String) {
         
     }
     
     func updateProfile(profile: Profile, responseHandler: @escaping ResponseHandler<Bool>, _ errorHandler: @escaping ErrorHandler) {
         
     }
     
     func retriveUserInfo(responseHandler: @escaping ResponseHandler<Profile>, _ errorHandler: @escaping ErrorHandler) {
         
     }
     
     func logout(responseHandler: @escaping ResponseHandler<Bool>) {
         
     }
     
     
 }
 
