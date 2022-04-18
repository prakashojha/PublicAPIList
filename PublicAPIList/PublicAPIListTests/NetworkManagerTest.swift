//
//  NetworkManagerTest.swift
//  PublicAPIListTests
//
//  Created by Saumya Prakash on 15/04/22.
//

import XCTest
@testable import PublicAPIList

class NetworkManagerTest: XCTestCase {

    let networkManager: APIServiceProtocol = NetworkManager()
    let mockNetworkManager: APIServiceProtocol = MockNetworkManager()
    
    func test_requestData_Success(){
        let expectation = expectation(description: "test_requestData_Success")
        networkManager.requestData(fromURL: Constant.randomAPILink) { result in
            switch(result){
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }

            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_requestData_Fail(){
        let link = "www.google.com"
        let expectation = expectation(description: "test_requestData_Success")
        networkManager.requestData(fromURL: link) { result in
            switch(result){
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }

            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
