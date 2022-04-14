//
//  PublicAPIListRouter.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 14/04/22.
//

import Foundation
import UIKit

class PublicAPIListRouter: RouterProtocol{
    
    private let navigationComtroller: UINavigationController
    var view : PublicAPIListViewController!
    var interactor: InteractorProtocol?
    var presentor: PresentorProtocol?
    var router: RouterProtocol?
    
    
    init(navigationController: UINavigationController){
        self.navigationComtroller = navigationController
    }
    
    func createModeul() -> UIViewController{
        view = PublicAPIListViewController()
        interactor = PublicAPIListInteractor(apiService: NetworkManager())
        presentor = PublicAPIListPresentor(interactor: interactor!)
        router = PublicAPIListRouter(navigationController: navigationComtroller)
        
        view.presentor = presentor
        view.presentor?.view = view
        view.presentor?.router = router
        view.presentor?.interactor = interactor
        view.presentor?.interactor?.presentor = presentor
        
        return view
    }
    
    func loadDetailPage(withUrl: String){
        
    }
    
}
