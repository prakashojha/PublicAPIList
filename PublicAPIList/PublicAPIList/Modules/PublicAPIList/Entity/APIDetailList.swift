//
//  APIDetailList.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation


///Entity for holding API detail received form API call
struct APIDetailList: Decodable{
    let count: Int
    let entries: [APIDetail]
    
    enum CodingKeys: String, CodingKey{
        case count = "count"
        case entries = "entries"
    }
}

///Single API Detail
struct APIDetail: Decodable{
    let api: String
    let description: String
    let auth: String
    let https: Bool
    let cors: String
    let link: String
    let category: String
    
    enum CodingKeys: String, CodingKey{
        case api = "API"
        case description = "Description"
        case auth = "Auth"
        case https = "HTTPS"
        case cors = "Cors"
        case link = "Link"
        case category = "Category"
    }
    
}

