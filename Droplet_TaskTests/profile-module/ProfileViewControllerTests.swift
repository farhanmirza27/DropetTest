//
//  ProfileViewControllerTests.swift
//  Droplet_TaskTests
//
//  Created by Farhan Mirza on 08/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import XCTest
@testable import Droplet_Task

class ProfileViewControllerTests: XCTestCase {
    
    //ProfileViewController tests
    var sut : ProfileViewController?
    var mockedPresenter : MockedPresenter?
    
    override func setUp() {
        sut = ProfileViewController()
        mockedPresenter = MockedPresenter()
        sut?.presenter = mockedPresenter
        sut?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut = nil
        mockedPresenter = nil
    }
    // test viewDidLoad called
    func testViewDidLoad() {
        sut?.viewDidLoad()
        XCTAssertTrue(mockedPresenter!.viewdidloadCalled)
    }
    // test UpdateProfile called
    func testUpdateProfile() {
        let profile = Profile(firstName: "fname", lastName: "lname", phone: "123456", email: "test@test.com", location: "Cambridge", profilePicture: "")
        sut?.saveBtn.sendActions(for: .touchUpInside)
        sut?.presenter?.updateProfile(profile: profile)
        XCTAssertTrue(mockedPresenter!.updateProfileCalled)
    }
    // test logout called
    func testLogout() {
        sut?.logout()
        XCTAssertTrue(mockedPresenter!.logoutCalled)
    }
    
    // mocked presenter
    class MockedPresenter : ViewToPresenterProfileProtocol {
        var viewdidloadCalled = false
        var updateProfileCalled = false
        var logoutCalled = false
        
        var view: PresenterToViewProfileProtocol?
        var interactor: PresenterToInteractorProfileProtocol?
        var router: PresenterToRouterProfileProtocol?
        
        func viewDidLoad() {
            viewdidloadCalled = true
        }
        
        func updateProfile(profile: Profile) {
            updateProfileCalled = true
        }
        
        func logout() {
            logoutCalled = true
        }
    }
    
}
