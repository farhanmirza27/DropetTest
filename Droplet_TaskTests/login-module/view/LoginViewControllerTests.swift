//
//  LoginViewControllerTests.swift
//  Droplet_TaskTests
//
//  Created by Farhan Mirza on 07/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import XCTest
@testable import Droplet_Task

class LoginViewControllerTests: XCTestCase {
    // LoginViewController test
    var sut : LoginViewController?
    var mockedPresenter : MockedPresenter?

    override func setUp() {
        sut = LoginViewController()
        mockedPresenter = MockedPresenter()
        sut?.presenter = mockedPresenter
        sut?.loadViewIfNeeded()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockedPresenter = nil
        super.tearDown()
    }
    
    // test viewDidLoad called
    func testviewdidLoad() {
        sut?.viewDidLoad()
        XCTAssertTrue(mockedPresenter!.viewDidLoadCalled)
    }
    // test verifyNumber called
    func testverifyNumber() {
        sut?.proceedBtn.tag = 0
        sut?.phoneNumTF.text = "212"
        sut?.proceedBtn.sendActions(for: .touchUpInside)
        XCTAssertTrue(mockedPresenter!.verifyNumberCalled)
        
    }
    // test login called
    func testLogin() {
        sut?.proceedBtn.tag = 1
        sut?.phoneNumTF.text = "212"
        sut?.codeTF.text = "23234"
        sut?.proceedBtn.sendActions(for: .touchUpInside)
        sut?.presenter?.login(code: "1234")
        XCTAssertTrue(mockedPresenter!.loginCalled)
        
    }
    
    // mocked presenter
    class MockedPresenter : ViewToPresenterLoginProtocol  {
        
        var viewDidLoadCalled = false
        var verifyNumberCalled = false
        var loginCalled = false
        var showProfileCalled = false
        
        var view: PresenterToViewLoginProtocol?
        var interactor: PresenterToInteractorLoginProtocol?
        var router: PresenterToRouterLoginProtocol?
        
        func viewDidLoad() {
            viewDidLoadCalled = true
        }
        
        func verifyNumber(number: String) {
            verifyNumberCalled = true
        }
        
        func login(code: String) {
            loginCalled = true
        }
        
        func showProfile(from: UIViewController) {
            showProfileCalled = true
        }
        
    }
}
