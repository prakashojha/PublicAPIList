//
//  MockNetworkManager.swift
//  PublicAPIListTests
//
//  Created by Saumya Prakash on 15/04/22.
//

import XCTest
@testable import PublicAPIList

class MockNetworkManager: APIServiceProtocol{
    
    func requestData(fromURL: String, completion: @escaping (Result<Data, Error>) -> Void) {
        
        if let url = Bundle.main.url(forResource: fromURL, withExtension: "json") {
            
            let data = try? Data(contentsOf: url)
            if let apiData = data{
                completion(.success(apiData))
            }
            else{
                completion(.failure(NetworkError.DataNotFound))
                
            }
            
        }
        else{
            completion(.failure(NetworkError.InvalidURL))
        }
        
    }
}
