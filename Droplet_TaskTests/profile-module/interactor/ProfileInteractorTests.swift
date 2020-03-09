//
//  ProfileInteractorTests.swift
//  Droplet_TaskTests
//
//  Created by Farhan Mirza on 09/03/2020.
//  Copyright © 2020 Farhan Mirza. All rights reserved.
//

import XCTest
@testable import Droplet_Task

class ProfileInteractorTests: XCTestCase {
    
    // ProfileInteractor tests
    
    var sut : ProfileInteractor?
    var mockedFirebaseClient : MockedFirebaseClient?
    
    override func setUp() {
        sut = ProfileInteractor()
        mockedFirebaseClient =  MockedFirebaseClient()
        sut?.firebaseClient = mockedFirebaseClient
    }
    
    override func tearDown() {
        sut = nil
        mockedFirebaseClient = nil
        super.tearDown()
    }
    // test profile data fetch called
    func testRetreiveProfileData() {
        sut?.getProfileData()
        XCTAssertTrue(mockedFirebaseClient!.retriveProfileData)
    }
    // test update profile data called
    func testUpdateProfileData() {
        let profile = Profile(firstName: "fname", lastName: "lname", phone: "2134456", email: "test@test.com", location: "", profilePicture: "")
        sut?.updateProfile(profile: profile)
        XCTAssertTrue(mockedFirebaseClient!.updateProfileSucess)
    }
    // test logout called
    func testLogout() {
        sut?.logout()
        XCTAssertTrue(mockedFirebaseClient!.logoutPeformed)
    }
    
}
