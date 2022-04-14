//
//  PublistAPIListPresentor.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation

class PublistAPIListPresentor: PresentorProtocol{
    
    var interactor: InteractorProtocol?
    var router: RouterProtocol?
    weak var view: ViewProtocol?
    
    init(interactor: InteractorProtocol){
        self.interactor = interactor
    }
    
    
    //MARK:- Manage call  from View To Interactors
    func loadTableEntries(){
        interactor?.loadTableEntries()
    }
    
    func fetchAllEntries(){
        interactor?.fetchAllEntries()
    }
    
    func loadDetailPage(withUrl: String){
        print("calling router")
        router?.loadDetailPage(withUrl: withUrl)
    }
    

    
    // MARK:- Manage call From Interactor To View
    func didLoadTableEntries(apiData: [APIDetail]) {
        print("didFinishLoadingAPIs")
        (view as! PublicAPIListViewController).onFinishLoadTableEntries(with: apiData)
        
    }
    
    func didFetchAllEntries(status: Bool) {
        if status {
            print("didFetchAllEntries")
            (view as! PublicAPIListViewController).onFinishFetchAllEntries()
        }
        else{
            print("Unable to fetch entries")
        }
        
    }
}
