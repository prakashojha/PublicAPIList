//
//  APIServiceProtocol.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation

protocol APIServiceProtocol{
    func requestData(fromURL: String, completion: @escaping (Result<Data, Error>)->Void)
}
