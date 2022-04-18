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
    
    
    //MARK:- Mock Test
    
    func test_requestData_ValidLink_Mock(){
        mockNetworkManager.requestData(fromURL: "MockData") { result in
            switch(result){
            case .success(let data):
                XCTAssertNotNil(data)
            case .failure(let error):
                XCTAssertNil(error)
            }
        }
    }
    
    func test_requestData_InValidLink_Mock(){
        mockNetworkManager.requestData(fromURL: "Invalid") { result in
            switch(result){
            case .success(let data):
                XCTAssertNil(data)
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
    func test_requestData_CorrectData_Mock(){
        mockNetworkManager.requestData(fromURL: "MockData") { result in
            switch(result){
            case .success(let data):
                let allAPIDetail = try? JSONDecoder().decode(APIDetailList.self, from: data)
                XCTAssertNotNil(allAPIDetail)
                XCTAssertEqual(allAPIDetail?.entries[0].category, "Development")
                
            case .failure(let error):
                XCTAssertNotNil(error)
            }
        }
    }
    
}
