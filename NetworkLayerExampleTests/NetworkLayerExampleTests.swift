//
//  NetworkLayerExampleTests.swift
//  NetworkLayerExampleTests
//
//  Creavar by Alessio Roberto on 02/03/2017.
//  Copyright © 2017 Tomasz Szulc. All rights reserved.
//

import XCTest

class NetworkLayerExampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        NetworkLayerConfiguration.setup()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSignIn() {
        let operation = SignInOperation(email: "a@b.com", password: "qwerty", service: MockSignInBackendService())
        
        let expectedResult = expectation(description: "Async request")
        
        operation.success = { item in
            let token = item.token
            let uniqueId = item.uniqueId
            
            XCTAssertEqual(token, MockSignIn.token)
            XCTAssertEqual(uniqueId, MockSignIn.uniqueId)
            
            expectedResult.fulfill()
        }
        
        operation.failure = { error in
            XCTFail()
        }
        
        NetworkQueue.shared.addOperation(operation)
        
        waitForExpectations(timeout: 10, handler:nil)
    }
    
    func testSignUp() {
        let expectedResult = expectation(description: "Async request")
        
        let user = UserItem(firstName: MockSignUp.name, lastName: MockSignUp.surname, email: MockSignUp.email, phoneNumber: nil)
        
        let operation = SignUpOperation(user: user, password: "", service: MockSignUpBackendService())
        
        operation.success = { item in
            XCTAssertEqual(item.firstName, MockSignUp.name)
            XCTAssertEqual(item.lastName, MockSignUp.surname)
            XCTAssertEqual(item.email, MockSignUp.email)
            
            expectedResult.fulfill()
        }
        
        operation.failure = { error in
            XCTFail()
        }

        NetworkQueue.shared.addOperation(operation)

        waitForExpectations(timeout: 10, handler:nil)
    }
    
    func testShoppingMapper() {
        let result = [["unique_id": "123qwe", "name": "foo", "price": 2.3], ["unique_id": "qwe123", "name": "foo", "price": 2.3]]
        
        do {
            let map = try UserShoppingResponseMapper.process(result)
            XCTAssertNotNil(map)
            XCTAssertTrue(map.count == 2)
        } catch {
            XCTFail()
        }
    }
    
    func testUserShopping() {
        let expectedResult = expectation(description: "Async request")
        
        let operation = UserShoppingOperation(uniqueId: "asdasd123", service: MockUserShoppingBackendService())
        
        operation.success = { items in
            XCTAssertNotNil(items)
            XCTAssertTrue(items.count == 2)
            
            let first = items.first
            
            XCTAssertEqual(first?.price, 2.3)
            
            expectedResult.fulfill()
        }
        
        operation.failure = { error in
            XCTFail()
        }
        
        NetworkQueue.shared.addOperation(operation)
        
        waitForExpectations(timeout: 10.0, handler:nil)
    }


}

extension XCTest {
    struct MockSignIn {
        static let token = "aaaa"
        static let uniqueId = "bbbb"
    }
    
    struct MockSignUp {
        static let name = "Alessio"
        static let surname = "Roberto"
        static let email = "a@b.com"
    }
    
    class MockSignInBackendService: BackendService {
        func request(_ request: BackendAPIRequest,
                              success: ((Any?) -> Void)? = nil,
                              failure: ((NSError) -> Void)? = nil) {
            
            let result = ["token": MockSignIn.token, "unique_id": MockSignIn.uniqueId]
            
            success?(result)
        }
        
        internal func cancel() {}
    }
    
    class MockSignUpBackendService: BackendService {
        func request(_ request: BackendAPIRequest, success: ((Any?) -> Void)?, failure: ((NSError) -> Void)?) {
            
            let result = ["unique_id": MockSignIn.uniqueId, "first_name": MockSignUp.name, "last_name": MockSignUp.surname, "email": MockSignUp.email, "phone_number": ""]
            
            success?(result)
        }
        
        internal func cancel() {}
    }
    
    class MockUserShoppingBackendService: BackendService {
        func request(_ request: BackendAPIRequest, success: ((Any?) -> Void)?, failure: ((NSError) -> Void)?) {
            let result = [["unique_id": "123qwe", "name": "foo", "price": 2.3], ["unique_id": "qwe123", "name": "foo", "price": 2.3]]
            
            success?(result)
        }
        
        internal func cancel() {}
    }
}

