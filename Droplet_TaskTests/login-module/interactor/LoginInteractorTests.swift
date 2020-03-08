//
//  LoginInteractorTests.swift
//  Droplet_TaskTests
//
//  Created by Farhan Mirza on 08/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import Foundation

import XCTest
@testable import Droplet_Task

class LoginInteractorTests: XCTestCase {
    // LoginInteractor tests
    var sut : LoginInteractor?
    var mockedFirebaseClient : MockedFirebaseClient?
    
    override func setUp() {
        sut = LoginInteractor()
        mockedFirebaseClient = MockedFirebaseClient()
        sut?.firebaseClient = mockedFirebaseClient
    }
    // test user already logged in test
    func testUserLoggedIn() {
        sut?.checkUserLoggedIn()
        XCTAssertTrue(mockedFirebaseClient!.userLoggedIn)
    }
    // test verifyPhoneNumber called
    func testVerifyPhoneNumber() {
        sut?.verifyNumber(number: "123456")
        XCTAssertTrue(mockedFirebaseClient!.verifyNumberSucess)
    }
    // test login called
    func testLogin() {
        sut?.login(code: "12345")
        XCTAssertTrue(mockedFirebaseClient!.loginSucess)
    }
    
}
