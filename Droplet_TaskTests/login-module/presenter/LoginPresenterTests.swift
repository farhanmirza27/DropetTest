//
//  LoginPresenterTests.swift
//  Droplet_TaskTests
//
//  Created by Farhan Mirza on 08/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import XCTest
@testable import Droplet_Task

class LoginPresenterTests: XCTestCase {
    // LoginPresenter tests
    var sut : LoginPresenter?
    var mockedView : MockedView?
    var mockedInteractor : MockedInteractor?
    var mockedRouter : MockedRouter?
    
    override func setUp() {
        sut = LoginPresenter()
        mockedView = MockedView()
        mockedInteractor = MockedInteractor()
        mockedRouter = MockedRouter()
        
        mockedInteractor?.presenter = sut
        sut?.view = mockedView
        sut?.interactor = mockedInteractor
        sut?.router = mockedRouter
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockedView = nil
        mockedInteractor = nil
        super.tearDown()
    }
    // test logged in user
    func testLoggedInUserSession() {
        mockedInteractor?.sessionExist = true
        sut?.viewDidLoad()
        XCTAssertTrue(mockedView!.userLoginSucess)
    }
    // test verifyPhoneNumber sucess
    func testVerifyPhoneNumberSucess() {
        mockedInteractor?.phoneNumberVerified = true
        sut?.verifyNumber(number: "1234568")
        XCTAssertTrue(mockedView!.phoneNumberVerificationSuccess)
    }
    // test loginSucess
    func testLoginSucess() {
        mockedInteractor?.codeVerified = true
        sut?.login(code: "1235")
        XCTAssertTrue(mockedView!.userLoginSucess)
    }
    // test loginFailed
    func testLoginFail() {
        mockedInteractor?.codeVerified = false
        sut?.login(code: "12356")
        XCTAssertFalse(mockedView!.userLoginSucess)
    }
    // test navigation to profile
    func testNavigateToProfileView() {
        sut?.showProfile(from: LoginViewController())
        XCTAssertTrue(mockedRouter!.profileViewPresented)
    }
    
    // mocked view
    class MockedView : PresenterToViewLoginProtocol {
        var userLoginSucess = false
        var phoneNumberVerificationSuccess = false
        var error : String?
        
        func phoneNumberVerificationSucess() {
            phoneNumberVerificationSuccess = true
        }
        
        func loginSucess() {
            userLoginSucess = true
        }
        
        func error(error: String) {
            self.error = error
        }
        
        
    }
    
    // mocked interactor
    class MockedInteractor : PresenterToInteractorLoginProtocol {
        var sessionExist = false
        var phoneNumberVerified = false
        var codeVerified = false
        
        var presenter: InteractorToPresenterLoginProtocol?
       var firebaseClient: FirebaseClientProtocol?
        
        func checkUserLoggedIn() {
            if sessionExist {
                presenter?.loginSuccess()
            }
        }
        
        func verifyNumber(number: String) {
            if phoneNumberVerified {
                presenter?.phoneVerifcationSucess()
            }
            else {
                presenter?.fail(error: "Number verification failed")
            }
        }
        
        func login(code: String) {
            if codeVerified {
                presenter?.loginSuccess()
            }
            else {
                presenter?.fail(error: "code verification failed")
            }
        }
        
    }
    
    // mocked router
    class MockedRouter : PresenterToRouterLoginProtocol {
        var profileViewPresented = false
        
        static func createModule() -> LoginViewController {
        return LoginViewController()
        }
        
        func showProfile(from: UIViewController) {
            profileViewPresented = true
        }
        
        
    }
    
}
