//
//  PublicListAPIInteractor.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation

class PublicAPIListInteractor: InteractorProtocol{
    
    weak var presentor: PresentorProtocol?
    
    var categories: [APIDetail] = []
    var apiDetail: [String] = []
    let apiService: APIServiceProtocol!
    
    init(apiService: APIServiceProtocol){
        self.apiService = apiService
    }
    
    
    ///Fetch 10 random API
    func loadTableEntries(){
        let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
        let dispatchGroup = DispatchGroup()
        let dispatchSemaphore = DispatchSemaphore(value: 10)
        
        dispatchQueue.async(group: dispatchGroup) { [weak self] in
            guard let self = self else { return }
            for _ in 0...10 {
                dispatchGroup.enter()
                dispatchSemaphore.wait()
                
                self.apiService.requestData(fromURL: Constant.randomAPILink) { result in
                    switch(result){
                    case .success(let data):
                        if let allAPIDetail = try? JSONDecoder().decode(APIDetailList.self, from: data){
                            self.categories.append(contentsOf: allAPIDetail.entries)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    dispatchGroup.leave()
                    dispatchSemaphore.signal()
                }
            }
        }
        dispatchGroup.notify(queue: .main) { [self] in
            self.presentor?.didLoadTableEntries(apiData: categories)
        }
    }
}
