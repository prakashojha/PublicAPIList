//
//  PublicListAPIModuleGenerator.swift
//  PublicAPIList
//
//  Created by Saumya Prakash on 18/04/22.
//

import Foundation
import UIKit

class PublicListAPIModuleGenerator{
    
    let navigationController: UINavigationController
    var view : (ViewProtocol & UIViewController)!
    var interactor: InteractorProtocol?
    var presentor: (PresentorProtocol & TableViewModelProtocol)?
    var router: RouterProtocol?
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func generateModules()->UIViewController{
        
        view = PublicAPIListViewController()
        router = PublicAPIListRouter(navigationController: navigationController)
        interactor = PublicAPIListInteractor(apiService: NetworkManager())
        presentor = PublicAPIListPresentor()
        
        
        view.presentor = presentor
        view.presentor?.view = view
        view.presentor?.router = router
        view.presentor?.interactor = interactor
        view.presentor?.interactor?.presentor = presentor
        
        return view
        
    }
    
}
