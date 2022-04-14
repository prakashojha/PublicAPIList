//
//  PublicListAPIInteractor.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation

class PublicListAPIInteractor: InteractorProtocol{
    
    weak var presentor: PresentorProtocol?
    
    var categories: [APIDetail] = []
    var apiDetail: [String] = []
    let apiService: APIServiceProtocol!
    
    init(apiService: APIServiceProtocol){
        self.apiService = apiService
    }
    
    
    ///Fetch all the entries from API
    func loadTableEntries(){
        var tableEntries: [APIDetail] = []
        for _ in 0...15{
            if let element = self.categories.randomElement(){
                tableEntries.append(element)
            }
            
        }
        self.presentor?.didLoadTableEntries(apiData: tableEntries)
    }


    func fetchAllEntries(){
        apiService.requestData(fromURL: Constant.allAPICategoriesURL) { result in
            switch(result){
            case .success(let data):
                if let allAPIDetail = try? JSONDecoder().decode(APIDetailList.self, from: data){
                    self.categories.append(contentsOf: allAPIDetail.entries)
                    self.presentor?.didFetchAllEntries(status: true)
                }
                else{
                    self.presentor?.didFetchAllEntries(status: false)
                    
                }
            case .failure(let error):
                print(error.localizedDescription)
                self.presentor?.didFetchAllEntries(status: false)
            }
            
        }
        
    }
}
