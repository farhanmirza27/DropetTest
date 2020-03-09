//
//  ProfilePresenterTests.swift
//  Droplet_TaskTests
//
//  Created by Farhan Mirza on 09/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import XCTest
@testable import Droplet_Task

class ProfilePresenterTests: XCTestCase {
    
    //ProfilePresenter tests
    
    var sut : ProfilePresenter?
    var mockedView : MockedView?
    var mockedInteractor : MockedInteractor?
    var mockedRouter : MockedRouter?
    
    override func setUp() {
        sut = ProfilePresenter()
        mockedView = MockedView()
        mockedInteractor = MockedInteractor()
        mockedRouter = MockedRouter()
        
        mockedInteractor?.presenter = sut
        sut?.interactor = mockedInteractor
        sut?.view = mockedView
        sut?.router = mockedRouter
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        mockedView = nil
        mockedInteractor = nil
        mockedRouter = nil
    }
    
    func testViewDidLoad() {
        mockedInteractor?.dataReturned = true
        sut?.viewDidLoad()
        XCTAssertTrue(mockedView!.displayProfileCalled)
    }
    
    func testupdateProfile() {
        mockedInteractor?.updateProfileSucess = true
        let profile = Profile(firstName: "fname", lastName: "lname", phone: "12345678", email: "test@test.com", location: "Cambridge", profilePicture: "")
        sut?.updateProfile(profile: profile)
        XCTAssertTrue(mockedView!.updateSucessCalled)
    }
    
    func testUpdateError() {
        mockedInteractor?.updateProfileSucess = false
        let profile = Profile(firstName: "fname", lastName: "lname", phone: "12345678", email: "test@test.com", location: "Cambridge", profilePicture: "")
        sut?.updateProfile(profile: profile)
        XCTAssertFalse(mockedView!.updateSucessCalled)
    }
    
    func testLogoutSucess() {
        sut?.logout()
        XCTAssertTrue(mockedRouter!.logoutPerfomed)
    }
    
    // mocked view
    class MockedView : PresenterToViewProfileProtocol {
        
        var displayProfileCalled = false
        var updateSucessCalled = false
        var errorCalled = false
        
        func displayProfile(profile: Profile) {
            displayProfileCalled = true
        }
        func updateSucess() {
            updateSucessCalled = true
        }
        func error(error: String) {
            errorCalled = true
        }
    }
    // mocked interactor
    class  MockedInteractor : PresenterToInteractorProfileProtocol {
        //  mocked profile
        let profile = Profile(firstName: "", lastName: "", phone: "", email: "", location: "", profilePicture: "")
        
        var dataReturned = false
        var updateProfileSucess = false
        var presenter: InteractorToPresenterProfileProtocol?
        
        var firebaseClient: FirebaseClientProtocol?
        
        func getProfileData() {
            if dataReturned {
                presenter?.success(profile: profile)
            }
            else {
                presenter?.fail(error: "failed to get data")
            }
        }
        func updateProfile(profile: Profile) {
            if updateProfileSucess {
                presenter?.updateSucess()
            }
            else {
                presenter?.fail(error: "update failed")
            }
        }
        func logout() {
            presenter?.logoutSucess()
        }
    }
    // mocked router
    class MockedRouter : PresenterToRouterProfileProtocol {
        var logoutPerfomed = false
        var navigationController: UINavigationController?
        
        static func createModule(navigationController: UINavigationController) -> ProfileViewController {
            return ProfileViewController()
        }
        func logout() {
            logoutPerfomed = true
        }
        
        
    }
    
}
