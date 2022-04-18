//
//  PublistAPIListPresentor.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation

class PublicAPIListPresentor: PresentorProtocol, TableViewModelProtocol{
    
    
   
    var interactor: InteractorProtocol?
    var router: RouterProtocol?
    weak var view: ViewProtocol?
    private var searchApiList: [APIDetail] = []

    
    private var apiData: [APIDetail] = []{
        didSet {
            view?.onFinishLoadTableEntries()
        }
    }
    
    
    //MARK:- Manage call  from View To Interactors
    func loadTableEntries(){
        interactor?.loadTableEntries()
    }
    
    
    func loadDetailPage(withUrl: String){
        router?.loadDetailPage(withUrl: withUrl)
    }
    
    
    
    // MARK:- Manage call From Interactor To View
    func didLoadTableEntries<T>(data: [T]) {
        ///call back to view
        if data.count > 0 , let apiDatArray = data as? [APIDetail] {
            self.apiData = apiDatArray
            self.searchApiList = self.apiData
            
        }
        else{
            view?.onDataLoadError()
            router?.showLoadErrorAlert(withError: "Unable to Load Data")
        }
        
    }
    
    
    ///Data implementing TableViewModelProtocol
    var sortAscending: Bool = true
    var isPagin: Bool = false
    
    
    var reusableCellIdentifier: String{
        return "PublicAPIListCell"
    }
    
    
    var isPaginating: Bool {
        get { return isPagin }
        set{ isPagin = newValue }
    }
    
    
    var heightForRow: Float {
        return Float(120)
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfRowsInSection: Int {
        return apiData.count
    }
    
    func cellForRow(at indexPath: Int) -> APIDetail? {
        return apiData.count > 0  ? apiData[indexPath] : nil
    }
    
    
    func remove(at indexPath: Int){
        self.apiData.remove(at: indexPath)
    }
    
    func insert(item: APIDetail?, at indexPath: Int){
        guard let item = item, indexPath < apiData.count else { return }
        self.apiData.insert(item, at: indexPath)
    }
    
    func updateSearchResults(searchText: String){
        self.apiData = searchApiList.filter { $0.category!.hasPrefix(searchText) }
    }
    
    func sort(){
        sortAscending == true ? apiData.sort{$0.category! < $1.category!} : apiData.sort{$0.category! > $1.category!}
        sortAscending = !sortAscending
        
    }
}
