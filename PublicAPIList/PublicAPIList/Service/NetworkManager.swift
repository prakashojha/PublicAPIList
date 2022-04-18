//
//  NetworkManager.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation

enum NetworkError: Error{
    case DataNotFound
    case InvalidURL
    case URLNotFormed
}


class NetworkManager: APIServiceProtocol{
    
    func createURLRequest(fromURLString: String)->URLRequest?{
        var urlRequest: URLRequest?
        
        if let url = URL(string: fromURLString) {
            urlRequest = URLRequest(url: url)
            urlRequest?.httpMethod = "GET"
        }
        return urlRequest
    }
    
    
    func requestData(fromURL: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = createURLRequest(fromURLString: fromURL) else {
            completion(.failure(NetworkError.URLNotFormed))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil, let data = data else {
                completion(.failure(error!))
                return
            }
            completion(.success(data))
        }.resume()
    }

}
