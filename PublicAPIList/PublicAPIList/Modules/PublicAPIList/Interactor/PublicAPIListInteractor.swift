//
//  PublicListAPIInteractor.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation

class PublicAPIListInteractor: InteractorProtocol{
    
    weak var presentor: PresentorProtocol?
    let apiService: APIServiceProtocol!
    
    ///Used for persistance.
    var apiDetails: [APIDetail] = []
    
    init(apiService: APIServiceProtocol){
        self.apiService = apiService
    }
    
    
    ///Fetch 10 random API
    func loadTableEntries(){
        let dispatchQueue = DispatchQueue.global(qos: .userInitiated)
        let dispatchGroup = DispatchGroup()
        dispatchQueue.async(group: dispatchGroup) { [weak self] in
            guard let self = self else { return }
            for _ in 0...9 {
                dispatchGroup.enter()
                self.apiService.requestData(fromURL: Constant.randomAPILink) { [weak self] result in
                    switch(result){
                    case .success(let data):
                        if let allAPIDetail = try? JSONDecoder().decode(APIDetailList.self, from: data){
                            self?.apiDetails.append(contentsOf: allAPIDetail.entries)
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.presentor?.didLoadTableEntries(data: self.apiDetails)
            
        }
    }

}
